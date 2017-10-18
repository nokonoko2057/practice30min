//
//  C4Manager.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/01.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import C4

class C4Manager: NSObject{
    
    
//    func c4Setup(canvas:UIView){
//        
//        canvas.backgroundColor = C4Grey
//        ShapeLayer.disableActions = true
//        ShapeLayer.disableActions = false
//    }
    
//    override func setup() {
//        //c4Manager.rotate(self.canvas)
//        
//    }
    
    func tapWavefront(canvas:View){
        
        print("tapWavefront")
    
        canvas.addTapGestureRecognizer{ locations, center, state in
            ShapeLayer.disableActions = true
            let circle = Circle(center: center, radius: 10)
            circle.lineWidth = 0.2
            circle.fillColor = black
            circle.strokeColor = black
            canvas.add(circle)
            ShapeLayer.disableActions = false
            
            print(center)
            
            let a = ViewAnimation(duration: 1.0) {
                circle.opacity = 0.0
                circle.transform.scale(10.0, 10.0)
            }
            a.addCompletionObserver {
                circle.removeFromSuperview()
            }
            a.curve = .Linear
            a.animate()
        }
    }
    
    func tapCircleShadow(canvas:View){
        canvas.addTapGestureRecognizer{ locations, center, state in
            ShapeLayer.disableActions = true
            let circle = Circle(center: center, radius: 10)
            
            circle.lineWidth = 0.2
            circle.fillColor = white
            circle.strokeColor = black
            
            //fillColorへの依存が大きい
            circle.shadow.color = C4Blue
            circle.shadow.offset = Size(0,0)
            circle.shadow.opacity  = 100

            
            canvas.add(circle)
            ShapeLayer.disableActions = false
            
            print(center)
            
            let a = ViewAnimation(duration: 1.0) {
                circle.opacity = 0.0
                circle.transform.scale(10.0, 10.0)
            }
            a.addCompletionObserver {
                circle.removeFromSuperview()
            }
            a.curve = .Linear
            a.animate()
        }
    }
    
    func polygonPanGesture(canvas: View){
        
        var polygonArray:[Polygon] = []
        
        let circle = Circle(center: canvas.center, radius: 4)
        circle.fillColor = C4Blue
        canvas.add(circle)
        
        canvas.addPanGestureRecognizer{locations, center, scale, velocity, state in
            
            if locations.count == 2{
                print(locations)
                
                let points = [locations[0], canvas.center, locations[1]]
                let polygon = Polygon(points)
                polygon.fillColor = clear
                polygon.strokeColor = C4Pink
                
                canvas.add(polygon)
                
                polygonArray.append(polygon)
            }
            
            if polygonArray.count > 200 {
                
                polygonArray[0].removeFromSuperview()
                polygonArray.remove(at: 0)
        
            }
        }
    }
    
//    func anglePanGesture(canvas: View){
//        
//        var oldPolygon:Polygon?
//        
//        let circle = Circle(center: canvas.center, radius: 4)
//        circle.fillColor = C4Blue
//        canvas.add(circle)
//        
//        canvas.addPanGestureRecognizer{locations, center, scale, velocity, state in
//            
//            
//            if locations.count == 2{
//                print(locations)
//                
//                if oldPolygon != nil {
//                    oldPolygon?.removeFromSuperview()
//                }
//                
//                let points = [locations[0], canvas.center, locations[1]]
//                let polygon = Polygon(points)
//                polygon.fillColor = clear
//                polygon.strokeColor = C4Pink
//                
//                canvas.add(polygon)
//                
//                oldPolygon = polygon
//   
//            }
//            
//        }
//    }

    
    
}
