//
//  d170402_C4noise.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/02.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import C4

class d170402_C4CircleShadow:CanvasController{
    
    override func viewDidAppear(_ animated: Bool) {
        C4Manager().tapCircleShadow(canvas: self.canvas)
    }
    
}

