//
//  d170401_C4Wavefront.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/01.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import C4


class d170401_C4Wavefront: CanvasController{
    
    override func viewDidAppear(_ animated: Bool) {
        C4Manager().tapWavefront(canvas: canvas)
    }
    
}


