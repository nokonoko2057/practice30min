//
//  d170611_LottieTest.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/06/11.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 
 https://github.com/airbnb/lottie-ios
 
 
 
 
*/


import UIKit
import Lottie

class d170611_LottieTest: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var lottieView:LOTAnimationView? = LOTAnimationView(
                    name: "LottieLogo1")
        lottieView?.frame = view.frame
        lottieView?.contentMode = .scaleAspectFit
        lottieView?.loopAnimation = true
        
        
        self.view.addSubview(lottieView!)
        
        lottieView?.play()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
