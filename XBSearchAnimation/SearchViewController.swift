//
//  SearchViewController.swift
//  XBSearchAnimation
//
//  Created by xiaobin liu on 2017/9/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

import Foundation
import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate {
    
    lazy var searchBar: UISearchBar = {
        let sbar = UISearchBar()
        sbar.barTintColor = UIColor.white
        sbar.showsCancelButton = true
        return sbar
    }()
    
    var topBar: UIToolbar = UIToolbar()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(topBar)
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        topBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20)
        searchBar.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 44)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismiss(animated: true, completion: nil)
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
