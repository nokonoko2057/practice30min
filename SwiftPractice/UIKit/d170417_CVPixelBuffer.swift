//
//  d170417_CVPixelBuffer.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/17.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 参考:
 SampleBuffer -> UIImage
 http://qiita.com/koki_h/items/91d9bf918df7c5788ffc
 
 http://qiita.com/hkato193/items/c0327e4c56ccf1c15e7d
 
 CoreImage>CIFilter
 http://qiita.com/kitanoow/items/2fd1c6dc415d7af769db
 
 
 UIImageとCGImageの違い
 http://anthrgrnwrld.hatenablog.com/entry/2016/08/05/124314
 
 [UIImage] <-> [CGImage] <-> [CIImage] In Swift
 http://qiita.com/imanishisatoshi/items/34d1e488d412cd23fd8d
 
 UIImage vs. CIImage vs. CGImage *******
 https://medium.com/@ranleung/uiimage-vs-ciimage-vs-cgimage-3db9d8b83d94
 
 Bitmap
 https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_images/dq_images.html
 
 memo
 
 CMSampleBuffer -> CVImageBufferRef -> CIImage -> CGImage -> UIImage

 
 Sample Code
     let imageData = UIImage.cgImage!.dataProvider!.data
     let data : UnsafePointer = CFDataGetBytePtr(imageData)
     let scale:CGFloat = 1.0//UIScreen.main.scale
     let address : Int = ((Int(self.size.width) * Int(pos.y * scale)) + Int(pos.x * scale)) * pixelDataByteSize
     
     let r = CGFloat(data[address])
     let g = CGFloat(data[address+1])
     let b = CGFloat(data[address+2])
     let a = CGFloat(data[address+3])

 
 CMSampleBuffer -> CVImageBufferRef -> CIImage -> CGImage -> UIImage
 -> CGImage -> ****** -> BytePointer(??) ->UnsafePointer(CFData)
 
 UIImage        <UIKit>
    >CGImage    <CoreGra>
    >CIImage    <CoreImage>   画像加工
        >CIFilter
 
 <UIImage>
 王道。生のイメージデータからイメージを作成
 通常、PNGまたはJPEG表現イメージを含むNSDataオブジェクトを取得し、それをUIImageに変換する。
 
 <CIImage>
 CIImageはイメージを表す不変オブジェクトです。それはイメージではありません。画像データのみが関連付けられています。画像を生成するために必要なすべての情報を持っています。
 
 <CGImage>
 CGImageはビットマップしか表現できません。ブレンドモードやマスキングなどのCoreGraphicsでの操作では、CGImageRefsが必要です。実際のビットマップデータにアクセスして変更する必要がある場合は、CGImageを使用できます。また、NSBitmapImageRepsに変換することもできます。
 
 
 
 動画
 AVCaptureDevice.devices()      デバイス選択
    ->AVCaptureSession          セッション経由
        ->AVCaptureStillImageOutput()   画像取得？
 
 AVCaptureVideoPreviewLayer.init(session: AVCaptureSession)
 self.view.layer.addSublayer(AVCaptureVideoPreviewLayer)
 
 Q:レイヤーで扱うメリット
 AVCaptureVideoPreviewLayer
 AVCaptureStillImageOutput このクラス確認
 
 
 UIImageの長さや位置の指定はpoint単位で行う
 CGImageの長さや位置の指定はpixel単位で行う
    UIImageを基準に指定したRectのx,y,width,heightにそれぞれscaleをかけたRectを準備する
    //scale: 1point当たりのpixel数
    let scale = imageSize.height / viewSize.height
 
 
 iOS 10.0-
    AVCapturePhotoOutput 推奨
    でも使いにくい
 
 AVCapturePhotoOutput
 http://qiita.com/inoue0426/items/4f31e61a494eeb507881
 
 http://dev.classmethod.jp/smartphone/ios-10-avfoundation-takephoto/
 
 http://galakutaapp.blogspot.jp/2017/03/avcapturephotooutput.html
 
 画像が回転する
 https://blog.isao.co.jp/auto_rotaion_image_from_ios/
 
*/


import UIKit
import AVFoundation

class d170417_CVPixelBuffer: UIViewController {
    
    
    
//    private var session: AVCaptureSession?
//    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    private var stillImageOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()
//
//    
//    override func viewDidAppear(_ animated: Bool) {
//        session = AVCaptureSession()
//        session?.sessionPreset = AVCaptureSessionPresetPhoto
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
//        
//        guard let _videoPreviewLayer = videoPreviewLayer else { return }
//        
//        _videoPreviewLayer.masksToBounds = true
//        _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//        
////        videoPreviewLayer.layer.addSublayer(_videoPreviewLayer)
//        self.view.layer.addSublayer(_videoPreviewLayer)
//        
//        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//        let input = try! AVCaptureDeviceInput(device: device)
//        session?.addInput(input)
//        
////        stillImageOutput = AVCapturePhotoOutput()
//        takePhoto()
//        session?.addOutput(stillImageOutput)
//        
//        
//    }
//    
//    func takePhoto() {
//        let settingsForMonitoring = AVCapturePhotoSettings()
//        
//        let settings = AVCapturePhotoSettings()
//        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
//        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
//                             kCVPixelBufferWidthKey as String: 160,
//                             kCVPixelBufferHeightKey as String: 160]
//        settings.previewPhotoFormat = previewFormat
//        
//        
////        settingsForMonitoring.flashMode = .auto
////        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
////        settingsForMonitoring.isHighResolutionPhotoEnabled = false
//        
//        stillImageOutput.capturePhoto(with: settings, delegate: self)
//    }
    
    
//    @IBOutlet weak var imageView: UIImageView!
    
    var captureSesssion: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    //    ↑ 書き換え AVCaptureStillImageOutput → AVCapturePhotoOutput
    
    func takePhoto(_ sender: Any){
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
    }
    //    AVCapturePhotoSettingsという新しいClassがAVCapturePhotoOutputと一緒に追加された。
    //    フラッシュなどの細かい設定はAVCapturePhotoSettingsで行う
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSesssion = AVCaptureSession()
        captureSesssion.sessionPreset = AVCaptureSessionPreset1920x1080
        stillImageOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        //        今回は📷のFront、Back、Dualの指定はしていないが、するとしたらこんな感じ
        //        do {
        //            var defaultVideoDevice: AVCaptureDevice?
        //            defaultVideoDevice = dualCameraDevice
        //        }
        //            else if let backCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
        //                defaultVideoDevice = backCameraDevice
        //            }
        //            else if let frontCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
        //               defaultVideoDevice = frontCameraDevice
        //            }
        //
        //            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice)
        //
        //            if session.canAddInput(videoDeviceInput) {
        //                session.addInput(videoDeviceInput)
        //                self.videoDeviceInput = videoDeviceInput
        //
        //                DispatchQueue.main.async {
        //                    let statusBarOrientation = UIApplication.shared.statusBarOrientation
        //                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
        //                    if statusBarOrientation != .unknown {
        //                        if let videoOrientation = statusBarOrientation.videoOrientation {
        //                            initialVideoOrientation = videoOrientation
        //                        }
        //                    }
        //
        //                    self.previewView.videoPreviewLayer.connection.videoOrientation = initialVideoOrientation
        //                }
        //            }
        //            else {
        //                setupResult = .configurationFailed
        //                session.commitConfiguration()
        //                return
        //            }
        //        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if (captureSesssion.canAddInput(input)) {
                captureSesssion.addInput(input)
                if (captureSesssion.canAddOutput(stillImageOutput)) {
                    captureSesssion.addOutput(stillImageOutput)
                    captureSesssion.startRunning()
                    let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSesssion)
                    captureVideoLayer.frame = self.view.bounds
                    captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                    self.view.layer.addSublayer(captureVideoLayer)
                }
            }
        }
        catch {
            print(error)
        }
    }

    
//AVCaptureVideoDataOutputSampleBufferDelegate
//    
//    var capDelegate:AVCaptureVideoDataOutputSampleBufferDelegate!
//    
//    // セッション.
//    var mySession : AVCaptureSession!
//    // デバイス.
//    var myDevice : AVCaptureDevice!
//    // 画像のアウトプット.
//    var myImageOutput: AVCapturePhotoOutput!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // セッションの作成.
//        mySession = AVCaptureSession()
//        
//        
//        
//        // デバイス一覧の取得.
//        let devices = AVCaptureDevice.devices()
//        
//        // バックカメラをmyDeviceに格納.
//        for device in devices! {
//            if((device as AnyObject).position == AVCaptureDevicePosition.back){
//                myDevice = device as! AVCaptureDevice
//            }
//        }
//        
//        // バックカメラからVideoInputを取得.
//        let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
//        // セッションに追加.
//        mySession.addInput(videoInput)
//        
//        // 出力先を生成.
//        let settingsForMonitoring = AVCapturePhotoSettings()
//        settingsForMonitoring.flashMode = .auto
//        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
//        settingsForMonitoring.isHighResolutionPhotoEnabled = false
//        
//        myImageOutput = AVCapturePhotoOutput()
//        myImageOutput.capturePhoto(with: settingsForMonitoring, delegate: self)
//        
//        mySession?.sessionPreset = AVCaptureSessionPresetPhoto
//        mySession.addOutput(myImageOutput)
//        
////        // 出力データの取得.
////        var videoDataOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
////        // カラーチャンネルの設定.
////        let dctPixelFormatType : Dictionary = [String(kCVPixelBufferPixelFormatTypeKey):kCVPixelFormatType_32BGRA]
////        //            let dctPixelFormatType : Dictionary = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]
////        videoDataOutput.videoSettings = dctPixelFormatType
////        
////        // デリゲート、画像をキャプチャするキューを指定.
////        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main/*DispatchQueue.main*/)
////        
////        // キューがブロックされているときに新しいフレームが来たら削除.
////        videoDataOutput.alwaysDiscardsLateVideoFrames = true
//        
//        // セッションに追加.
////        mySession.addOutput(myImageOutput)
////        mySession.addOutput(videoDataOutput)
//        
//        
//        // 画像を表示するレイヤーを生成.
//        let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
//        myVideoLayer?.frame = self.view.bounds
//        myVideoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//        
//        // Viewに追加.
//        self.view.layer.addSublayer(myVideoLayer!)
//        
//        // セッション開始.
//        mySession.startRunning()
//        
//        
//        
//        // UIボタンを作成.
//        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
//        myButton.backgroundColor = UIColor.red
//        myButton.layer.masksToBounds = true
//        myButton.setTitle("撮影", for: .normal)
//        myButton.layer.cornerRadius = 20.0
//        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
//        myButton.addTarget(self, action: #selector(onClickMyButton), for: .touchUpInside)
//        
//        // UIボタンをViewに追加.
//        self.view.addSubview(myButton);
//        
//    }
//    
//    // ボタンイベント.
//    func onClickMyButton(sender: UIButton){
//        
//        // ビデオ出力に接続.
//        // let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
//        let myVideoConnection = myImageOutput.connection(withMediaType: AVMediaTypeVideo)
//        
//        // 接続から画像を取得.
////        self.myImageOutput.captureStillImageAsynchronously(from: myVideoConnection, completionHandler: {(imageDataBuffer, error) in
////            if let e = error {
////                print(e.localizedDescription)
////                return
////            }
////            // 取得したImageのDataBufferをJpegに変換.
////            let myImageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: nil)
////            // JpegからUIIMageを作成.
////            let myImage = UIImage(data: myImageData!)
////            // アルバムに追加.
////            UIImageWriteToSavedPhotosAlbum(myImage!, nil, nil, nil)
////        })
//    }
//    
////    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
////        
////        let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
////        print("captureOutput")
////    }
//  
//    
    
}
//
extension d170417_CVPixelBuffer:AVCapturePhotoCaptureDelegate {
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        }else{
            print("PhotoCap")
        }
        
        print("PhotoCap")
        
    }
}
