//
//  d171126_3DTouch.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/11/27.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

class d171126_3DTouch: UIViewController {
    
    var label:UILabel = UILabel()
    var defaultWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultWidth = view.frame.size.width
        
        label.frame.size = CGSize(width: defaultWidth, height: defaultWidth)
        label.center = view.center
        label.backgroundColor = UIColor.blue
        
        view.addSubview(label)
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //
        if let touch = touches.first {
            
            let forcePara = touch.force / touch.maximumPossibleForce
            print("force:\(touch.force), max:\(touch.maximumPossibleForce)")
            print("touchPara:\(forcePara)")
            
            label.frame.size = CGSize(width: defaultWidth * forcePara, height: defaultWidth * forcePara)
            label.center = view.center
            //            label.center = touch.location(in: view)
            
        }
        
    }
    
}
