//
//  d170606_ChameleonTest.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/06/06.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 ChameleonFramework
 -http://dev.classmethod.jp/smartphone/iphone/ios_oss_color_chameleon/
 
 - [PageMenu/PageMenu: A paging menu controller built from other view controllers placed inside a scroll view (like Spotify, Windows Phone, Instagram)](https://github.com/PageMenu/PageMenu)
 - [cruisediary/Pastel: 🎨 Gradient animation effect like Instagram](https://github.com/cruisediary/Pastel)
 - [KyoheiG3/AttributedLabel: Easy to use, fast, and higher performance than UILabel.](https://github.com/KyoheiG3/AttributedLabel)
 - [TTTAttributedLabel/TTTAttributedLabel: A drop-in replacement for UILabel that supports attributes, data detectors, links, and more](https://github.com/TTTAttributedLabel/TTTAttributedLabel)
 - [Grouper/FlatUIKit: A collection of awesome flat UI components for iOS.](https://github.com/Grouper/FlatUIKit)
 - [ninjaprox/NVActivityIndicatorView: Collection of awesome loading animations](https://github.com/ninjaprox/NVActivityIndicatorView)
 - [GabrielAlva/Swift-Prompts: A Swift library to design custom prompts with a great scope of options to choose from.](https://github.com/GabrielAlva/Swift-Prompts)
 - [hanton/HTYTextField: A UITextField with bouncy placeholder.](https://github.com/hanton/HTYTextField)
 - [MailOnline/ImageViewer: An image viewer à la Twitter](https://github.com/MailOnline/ImageViewer)
 - [T-Pham/UITextField-Navigation: UITextField-Navigation makes it easier to navigate between UITextFields and UITextViews.](https://github.com/T-Pham/UITextField-Navigation)
 - [知ってるといいかもしれないライブラリ20選 - Qiita](http://qiita.com/ShuntaNakajima/items/1ac4f91a6688920a22f5)
 - [rs/SDWebImage: Asynchronous image downloader with cache support as a UIImageView category](https://github.com/rs/SDWebImage)


 
 
 
 
*/




import UIKit
import ChameleonFramework


class d170606_ChameleonTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.hidesNavigationBarHairline = true
        
        // Flatカラーを取得する
        let lightColor = UIColor.flatMint
        let darkColor = UIColor.flatMintColorDark()
        
        // Hexコードから色を生成する
        let hex1Color = UIColor(hexString: "#336699")
//        let hex2Color = //HexColor("#336699")
        
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.center = self.view.center
        
//        label.backgroundColor = lightColor
        
    

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
