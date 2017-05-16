//
//  d170516_UserNotificationsCalender.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/05/16.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//


/*
 
 
 UserNotifications
 https://developer.apple.com/reference/usernotifications
 
 UserNotificationsUI
 https://developer.apple.com/reference/usernotificationsui
 
 UNCalendarNotificationTrigger
 -> 日時から通知
 https://developer.apple.com/reference/usernotifications/uncalendarnotificationtrigger
 
 
 [iOS 10] User Notifications framework を使用して指定日時に発火するローカル通知を作成する
 http://dev.classmethod.jp/smartphone/iphone/wwdc-2016-user-notifications-time-local-2/
 
 課題:音の扱いどうする？
 
 
 */

import UIKit
import UserNotifications

class d170516_UserNotificationsCalender: UIViewController {
    
    private let BUTTON_NORMAL: Int = 1
    private let BUTTON_FIRE: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notificationの表示許可をもらう.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        // すぐにNotificationを発火するボタン.
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 80
        let posX: CGFloat = (self.view.bounds.width - buttonWidth) / 2
        let posY: CGFloat = 200
        
        let myButton: UIButton = UIButton(frame: CGRect(x: posX, y: posY, width: buttonWidth, height: buttonHeight))
        myButton.backgroundColor = UIColor.orange
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.tag = BUTTON_NORMAL
        myButton.setTitle("Notification", for: .normal)
        myButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchDown)
        view.addSubview(myButton)
        
        // 時間をおいてNotificationを発火するボタン.
        let posFireX: CGFloat = (self.view.bounds.width - buttonWidth) / 2
        let posFireY: CGFloat = 400
        
        let myFireButton: UIButton = UIButton(frame: CGRect(x: posFireX, y: posFireY, width: buttonWidth, height: buttonHeight))
        myFireButton.backgroundColor = UIColor.blue
        myFireButton.layer.masksToBounds = true
        myFireButton.layer.cornerRadius = 20.0
        myFireButton.tag = BUTTON_FIRE
        myFireButton.setTitle("Fire Notification", for: .normal)
        myFireButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchDown)
        view.addSubview(myFireButton)
        
        // UNMutableNotificationContent 作成
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "It's time!"
        content.sound = UNNotificationSound.default()
        
        // UNCalendarNotificationTrigger 作成
        var date = DateComponents()
        date.hour = 23
        date.minute = 54
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats: false)
        
        // id, content, trigger から UNNotificationRequest 作成
        let request = UNNotificationRequest.init(identifier: "CalendarNotification", content: content, trigger: trigger)
        
        // UNUserNotificationCenter に request を追加
        let Ncenter = UNUserNotificationCenter.current()
        Ncenter.add(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ボタンイベント.
     */
    internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton")
        if sender.tag == BUTTON_NORMAL {
            showNotification()
        } else if sender.tag == BUTTON_FIRE {
            showNotificationFire()
        }
    }
    
    /*
     Notificationを表示.
     */
    private func showNotification() {
        print("showNotification")
        
        var date = DateComponents()
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        
        // Notificationを生成.
        let content = UNMutableNotificationContent()
        
        // Titleを代入する.
        content.title = "Title1Show"
        
        // Bodyを代入する.
        content.body = "Hello Notification"
        
        // 音を設定する.
        content.sound = UNNotificationSound.default()
        
        // Requestを生成する.
        let request = UNNotificationRequest.init(identifier: "Title1", content: content, trigger: nil)
        
        // Noticationを発行する.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print("error:\(error)")
        }
    }
    
    /*
     Notificationを表示(10秒後)
     */
    private func showNotificationFire() {
        // Notificationを生成.
        let content = UNMutableNotificationContent()
        
        // Titleを代入する.
        content.title = "Title1Fire"
        
        // Bodyを代入する.
        content.body = "Hello Notification"
        
        // 音を設定する.
        content.sound = UNNotificationSound.default()
        
        // Triggerを生成する.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        
        // Requestを生成する.
        let request = UNNotificationRequest.init(identifier: "Title1", content: content, trigger: trigger)
        
        // Noticationを発行する.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print("error:\(error)")
            
        }
        
    }
    
}

/*import UIKit
 
 class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
 // 通知メッセージ
 private let notificationMessageOptions: NSArray = [
 "Hello",
 "Are you free?",
 "Thanks anyway"
 ]
 
 var notificationMessagePicker: UIPickerView!
 var notificationTimeEditor: UIDatePicker!
 
 var notificationMessage: String?
 var notificationTime: NSDate?
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // 通知許可
 //
 let types = UIUserNotificationType(rawValue:UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue)
 
 UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: types, categories: nil))
 
 //let setting = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: nil)
 //  UIApplication.shared.registerUserNotificationSettings(setting)
 
 // 通知内容を編集する
 notificationMessagePicker = UIPickerView()
 notificationMessagePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 180.0)
 
 notificationMessagePicker.delegate = self
 notificationMessagePicker.dataSource = self
 
 // 通知時間を設定する
 notificationTimeEditor = UIDatePicker()
 notificationTimeEditor.setDate(Date(), animated: true)
 
 
 notificationTimeEditor.datePickerMode = UIDatePickerMode.time
 notificationTimeEditor.layer.position = CGPoint(x:self.view.bounds.width/2, y: 240)
 notificationTimeEditor.minimumDate = NSDate() as Date
 notificationTimeEditor.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
 notificationTimeEditor.addTarget(self, action: #selector(self.fixNotificationTime(sender:)), for: .valueChanged)
 
 // 通知設定の決定ボタン
 let setNotificationButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
 
 setNotificationButton.backgroundColor = UIColor.orange
 setNotificationButton.layer.masksToBounds = true
 setNotificationButton.setTitle("設定", for: .normal)
 setNotificationButton.layer.cornerRadius = 20.0
 setNotificationButton.layer.position = CGPoint(x: self.view.bounds.width/2, y: 400)
 setNotificationButton.addTarget(self, action: #selector(self.setNotification(sender:)), for: .touchUpInside)
 
 self.view.addSubview(notificationMessagePicker)
 self.view.addSubview(notificationTimeEditor)
 self.view.addSubview(setNotificationButton)
 }
 
 
 // 通知の設定を行う
 func setNotification(sender: UIButton) {
 let notification: UILocalNotification = UILocalNotification()
 
 print(notificationMessage)
 notification.alertBody = notificationMessage
 notification.soundName = UILocalNotificationDefaultSoundName
 notification.timeZone = NSTimeZone.local
 
 print(notificationTime)
 notification.fireDate = notificationTime as Date?
 
 UIApplication.shared.scheduleLocalNotification(notification)
 print("set!")
 }
 
 // 通知内容の確定
 // pickerに表示する列数を返すデータソースメソッド
 func numberOfComponents(in pickerView: UIPickerView) -> Int {
 return 1
 }
 
 // pickerに表示する行数を返すデータソースメソッド
 func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
 return notificationMessageOptions.count
 }
 
 // pickerに表示する値を返すデリゲートメソッド
 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
 return notificationMessageOptions[row] as? String
 }
 
 // pickerが選択された際に呼ばれるデリゲートメソッド
 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
 print("row: \(row)")
 print("value: \(notificationMessageOptions[row])")
 notificationMessage = notificationMessageOptions[row] as? String
 
 }
 
 
 
 // 通知時間の確定
 func fixNotificationTime(sender: UIDatePicker) {
 notificationTime = sender.date as NSDate?
 
 print(fixNotificationTime)
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 }
 
 */
