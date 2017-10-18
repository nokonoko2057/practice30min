//
//  d171018_FSCalendar.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/10/18.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 - [WenchaoD/FSCalendar: A fully customizable iOS calendar library, compatible with Objective-C and Swift](https://github.com/WenchaoD/FSCalendar)
*/

import UIKit
import FSCalendar

class d171018_FSCalendar: UIViewController {
    
    var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        setupCalender()
    }
    
    func setupCalender(){
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height/2.0))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
    }

}

extension d171018_FSCalendar: FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "HELLO"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "world"
//    }
//
    
}


extension d171018_FSCalendar: FSCalendarDelegate {
    
}
