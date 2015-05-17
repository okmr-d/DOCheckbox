//
//  ViewController.swift
//  DOCheckbox
//
//  Created by Daiki Okumura on 2015/05/16.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let checkbox1 = DOCheckbox(frame: CGRectMake(50, 50, 10, 10))
        self.view.addSubview(checkbox1)
        
        let checkbox2 = DOCheckbox(frame: CGRectMake(50, 200, 20, 20))
        self.view.addSubview(checkbox2)
        
        let checkbox3 = DOCheckbox(frame: CGRectMake(50, 350, 100, 100))
        checkbox3.checkboxFrame = CGRectMake(0, 0, 50, 50)
        //checkbox3.checkboxFrame.origin = CGPoint(x: 25, y: 0)
        checkbox3.checkboxCornerRadius = 25
        checkbox3.checkboxBackgroundColor = UIColor.redColor()
        self.view.addSubview(checkbox3)
        */
        let checkbox4 = DOCheckbox(frame: CGRectMake(50, 50, 200, 200), checkboxFrame: CGRectMake(0, 0, 100, 100))
        /*
        checkbox4.checkboxCornerRadius = 15
        checkbox4.checkboxBorderWidth = 5
        checkbox4.checkboxBorderColor = UIColor.redColor()
        checkbox4.checkColor = UIColor.redColor()
        checkbox4.checkboxBackgroundColor = UIColor.whiteColor()
        */
        self.view.addSubview(checkbox4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

