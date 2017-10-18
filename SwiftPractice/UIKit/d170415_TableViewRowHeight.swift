//
//  d170415_TableViewRowHeight.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/15.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 参考: http://www.swift-study.com/uitableview-auto-cell-height/
 
 
*/

import UIKit

class d170415_TableViewRowHeight: UITableViewController {

    
    var articles:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Table view
    
    func tableViewSetup(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        articles = [
            "私わたくしはその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。",
            "この書の世に出づるにいたりたるは、函館にある秦慶治氏、及び信濃にある神津猛氏のたまものなり。労作終るの日にあたりて、このものがたりを二人の恩人のまへにさゝぐ。",
            "散文に二種あると考へてゐるが、一を小説、他を作文とかりに言つておく。",
            "機敏な晩熟児といふべき此の男が、現に存するのだから僕は機敏な晩熟児が如何にして存るママかその様を語らうと思ふ。"
        ]
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        
        cell.textLabel?.text = articles[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.layoutIfNeeded()

        return cell
    }
    
}
