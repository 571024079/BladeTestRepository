//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Handlecar on 16/5/26.
//  Copyright © 2016年 date. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame:firstFrame)
        firstView.backgroundColor = UIColor.blue
        view.addSubview(firstView)
        
        print(view.superview)
    }

}

