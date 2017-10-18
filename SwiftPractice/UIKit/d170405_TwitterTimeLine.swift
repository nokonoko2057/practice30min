//
//  TableViewController.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/05.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 参考
 - Xcode 8.2, Swift 3.0でTwitterの認証を通してタイムラインを取得するまで
    http://qiita.com/keisei_1092/items/32a96dbdb6bc394b0e8e
 
 
 MEMO
 - @escapingとは
 - ACAccount -> 登録アカウント？
 - twitterは標準搭載？
 - guard の復習
 - alert -> UIAlertController .actionSheet
            addActionで項目追加
 - error: 初期値はnil エラーが起きると !nil
    -> if error != nil { "error!"} else { "not error" }
 - try JSONSerialization.jsonObject 
 
*/

import UIKit
import Social
import Accounts

struct Tweet {
    let text: String
    let createdAt: String
    let user: User
    
    var dump: String {
        get {
            return "\(text) by @\(user.screenName)"
        }
    }
}

struct User {
    let name: String
    let screenName: String
    let profileImageURLHTTPS: String
}


class d170405_TwitterTimeLine: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        
        getAccounts { (accounts: [ACAccount]) -> Void in
            self.showAccountSelectSheet(accounts: accounts)
        }
    }

    
    // MARK: - Twitter
    var accountStore: ACAccountStore = ACAccountStore()
    var twitterAccount: ACAccount?
    var tweets: [Tweet] = []
    
    //①アカウント取得
    func getAccounts(callback: @escaping ([ACAccount]) -> Void) {
        let accountType: ACAccountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (granted: Bool, error: Error?) -> Void in
            //granted:アカウント利用 アプリ関係？
            guard error == nil else {
                print("error! \(error)")
                return
            }
            guard granted else {
                print("error! Twitterアカウントの利用が許可されていません")
                return
            }
            //accountStoreからアカウント取得
            let accounts = self.accountStore.accounts(with: accountType) as! [ACAccount]
            guard accounts.count != 0 else {
                //アカウント数が0の場合
                print("error! 設定画面からアカウントを設定してください")
                return
            }
            print("アカウント取得完了")
            callback(accounts)
        }
    }
    
    //②アカウント情報をアラート表示
    private func showAccountSelectSheet(accounts: [ACAccount]) {
        let alert = UIAlertController(title: "Twitter", message: "Choose an account", preferredStyle: .actionSheet)
        
        for account in accounts {
            alert.addAction(UIAlertAction(title: account.username, style: .default, handler: { [weak self] (action) -> Void in
                //アカウントが選択されたら
                if let unwrapSelf = self {
                    unwrapSelf.twitterAccount = account
                    unwrapSelf.getTimeline()
                }
            }))
        }
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2, width: 1.0, height: 1.0)
        alert.popoverPresentationController?.permittedArrowDirections = .down
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    //TimeLine取得:json
    private func getTimeline() {
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json?count=100")
        guard let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) else {
            return
        }
        request.account = twitterAccount
        request.perform { (responseData, response, error) -> Void in
            if error != nil {
                print(error ?? "error in performing request :[")
            } else {
                do {
                    guard let responseData = responseData else {
                        print("")
                        return
                    }
                    let result = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                    for tweet in result as! [AnyObject] { // errorsが返ってくることがある
                        guard let text = tweet["text"] as? String, let createdAt = tweet["created_at"] as? String else { // これmodel側でやるべきな感じ
                            print("failed to map tweet string from JSON")
                            return
                        }
                        
                        let user = tweet["user"] as? [String: Any]
                        guard let userName = user?["name"] as? String, let userScreenName = user?["screen_name"] as? String, let userProfileImageURLHTTPS = user?["profile_image_url_https"] as? String else {
                            print("failed to map user string from JSON")
                            return
                        }
                        
                        let tweetObject = Tweet(text: text, createdAt: createdAt, user: User(name: userName, screenName: userScreenName, profileImageURLHTTPS: userProfileImageURLHTTPS))
                        self.tweets.append(tweetObject)
                    }
                    // ここでなにかする
                    // （例えば self.tableView.reloadData() とか）
                    print(self.tweets)
                    self.tableView.reloadData()
                }  catch let error as NSError {
                    print(error)
                }
            }
        }
    }

    
    // MARK: - TableView
    
    func tableViewSetup(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
    }
    
    
    // MARK: Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(tweets)
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = tweets[indexPath.row].text

        return cell
    }
    

    /*
    // Override  to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
