//
//  HomeTableViewController.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/01.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var classArray = [d170401_C4Wavefront(),
                      d170402_C4CircleShadow()]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "cells")! as UITableViewCell
        
        cell.textLabel!.text = String(describing: type(of: classArray[indexPath.row]))


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(classArray[indexPath.row] as! UIViewController, animated: true)

    }
    
}
