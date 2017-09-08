//
//  ViewController.swift
//  XBSearchAnimation
//
//  Created by xiaobin liu on 2017/9/8.
//  Copyright © 2017年 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 按钮
    private var button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "搜索过渡动画"
        self.view.backgroundColor = .red
        
        button.backgroundColor = UIColor.gray
        button.setTitle("点击", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.center = self.view.center
        button.addTarget(self, action: #selector(ViewController.searchAnimation), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    @objc private func searchAnimation() {
        
        let vc = SearchViewController()
        let na = SearchAnimationNavigationController(rootViewController: vc)
        na.navigationBar.isHidden = true
        self.present(na, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

