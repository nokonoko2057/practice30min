//
//  d170413_BlurEffect.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/13.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//


/*
 参考　http://dev.classmethod.jp/references/ios8-uivisualeffectview/
 
 
*/

import UIKit

class d170413_BlurEffect: UIViewController {
    
    var imageViews:[UIImageView] = []
    var frameSize = UIScreen.main.bounds
    
    var blurImageView:UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        for i in 0...10{
            let imageView = UIImageView()
            
            let x = Double(arc4random_uniform(UInt32(frameSize.width)))
            let y = Double(arc4random_uniform(UInt32(frameSize.height)))

            let w = Double(arc4random_uniform(UInt32(frameSize.width/2)))
            let h = Double(arc4random_uniform(UInt32(frameSize.height/2)))

            imageView.frame = CGRect(x: x, y: y, width: w, height: h)
            
            var color:[CGFloat] = []
            
            for j in 0...3 {
                let c:CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
                color.append(c)
            }
            
            imageView.backgroundColor = UIColor(red: color[0], green: color[1], blue: color[2], alpha: color[3])
            self.view.add(imageView)
        }
        
        blurImageView = UIImageView()
        blurImageView.frame = CGRect(origin: .zero, size: frameSize.size)
        
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = blurImageView.frame
        
        blurImageView.add(visualEffectView)
        self.view.add(blurImageView)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
