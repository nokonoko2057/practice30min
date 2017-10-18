//
//  d170411_MakeUIImage.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/11.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 参考: http://dev.classmethod.jp/references/ios-8-colorimage/
 

 -UIGraphicsBeginImageContext   はじめて
 -UIGraphicsGetCurrentContext   設定して
 -UIGraphicsEndImageContext     画像ができる image = ____
 
 
 -UIGraphicsImageRenderer       推奨 iOS10-
    参考: http://dev.classmethod.jp/smartphone/iphone/ios-uigraphics-image-renderer/
 
*/

import UIKit

class d170411_MakeUIImage: UIViewController {
    
    var imageViewA:UIImageView!
    var imageViewB:UIImageView!
    
    var imageA:UIImage!
    var imageB:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageViewA = UIImageView()
        imageViewA.frame = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        self.view.add(imageViewA)
        
        imageViewB = UIImageView()
        imageViewB.frame =  CGRect(origin: CGPoint(x:0,y:UIScreen.main.bounds.height/2), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        self.view.add(imageViewB)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //UIGraphicsGetImageFromCurrentImageContext
        imageA = UIImage.colorImage(color: UIColor.cyan, size: imageViewA.frame.size)
        imageViewA.image = imageA
        
        
        //UIGraphicsImageRenderer
        imageB = UIImage.imageRender(color: UIColor.green, size: imageViewB.frame.size)
        imageViewB.image = imageB
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UIImage {
    class func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func imageRender(color: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image(actions: { rendererContext in
            // 描画処理
            rendererContext.cgContext.setFillColor(color.cgColor) // 色を指定
            rendererContext.fill(CGRect(origin: CGPoint.zero, size: size)) // 塗りつぶす
        })
    }
}
