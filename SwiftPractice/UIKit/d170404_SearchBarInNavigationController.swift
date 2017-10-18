//
//  d170404_C4AnglePanGesture.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/04/04.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit

class d170404_SearchBarInNavigationController: UIViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        setupSearchBar()
        self.view.backgroundColor = UIColor.white
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func setupSearchBar() {
        
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            var searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "TEST"
            searchBar.showsCancelButton = true
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            searchBar.keyboardType = UIKeyboardType.default
            
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
            searchBar.becomeFirstResponder()
        }
    }
}
