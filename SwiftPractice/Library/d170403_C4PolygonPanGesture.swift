//
//  d170403_C4Angle.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/03.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import C4

class d170403_C4PolygonPanGesture:CanvasController  {
    
    override func viewDidAppear(_ animated: Bool) {
        C4Manager().polygonPanGesture(canvas: canvas)
    }
}
