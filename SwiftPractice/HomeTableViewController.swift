//
//  HomeTableViewController.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/01.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var classArray
        = [
            d170516_UserNotificationsCalender(),
            d170417_CVPixelBuffer(),
            d170415_TableViewRowHeight(),
            d170413_BlurEffect(),
            d170412_CameraCapture(),
            d170411_MakeUIImage(),
            d170410_ReloadTableView(),
            d170406_MediaPlayer(),
            d170405_TwitterTimeLine(),
            d170404_SearchBarInNavigationController(),
            d170403_C4PolygonPanGesture(),
            d170402_C4CircleShadow(),
            d170401_C4Wavefront(),
        ]

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "cells")! as UITableViewCell
        cell.textLabel!.text = String(describing: type(of: classArray[indexPath.row]))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showVC:UIViewController!
//        if String(describing: type(of:classArray[indexPath.row])) == "d170404_C4AnglePanGesture" {
//            let storyboard = UIStoryboard(name: "d170404_searchBar", bundle: nil)
//            showVC = storyboard.instantiateViewController(withIdentifier: "searchBarTest")
//        }else{
//            showVC = classArray[indexPath.row] as! UIViewController
//        }
        
        showVC = classArray[indexPath.row] as! UIViewController
        navigationController?.pushViewController(showVC, animated: true)
    }
    
}
