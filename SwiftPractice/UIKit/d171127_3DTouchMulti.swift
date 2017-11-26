//
//  d171127_3DTouchMulti.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/11/27.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

class d171127_3DTouchMulti: UIViewController {

    
    var labels:[UILabel] = []
    
    var defaultWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultWidth = view.frame.size.width
        
        for i in 0...4 {
            var label = UILabel()
            label.frame.size = CGSize(width: defaultWidth, height: defaultWidth)
            label.center = view.center
            
            label.backgroundColor = UIColor.blue
            
            view.addSubview(label)
            
            labels.append(label)
        }
        
        view.isMultipleTouchEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var counter = 0
        
        for touch:UITouch in touches {
            let forcePara = touch.force / touch.maximumPossibleForce
            
            labels[counter].frame.size = CGSize(width: defaultWidth * forcePara, height: defaultWidth * forcePara)
            //            labels[counter].center = view.center
            labels[counter].center = touch.location(in: view)
            
            counter += 1
        }
        
    }

}
