//
//  ChildViewController.swift
//  DOCheckbox
//
//  Created by 奥村大樹 on 2015/05/17.
//  Copyright (c) 2015年 Daiki Okumura. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {
    
    var style: DOCheckboxStyle = .Default
    let titleStr: [DOCheckboxStyle : String] = [
        .Default            : "Square (Default)",
        .SquareFill         : "SquareFill",
        .RoundedSquare      : "RoundedSquare",
        .RoundedSquareFill  : "RoundedSquareFill",
        .Circle             : "Circle",
        .CircleFill         : "CircleFill"]
    var checkboxList: [DOCheckbox] = []
    let checkboxSizeList: [CGFloat] = [10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 45.0, 50.0]
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleStr[style]
        
        var y: CGFloat = 25.0
        
        // BLACK (Default)
        layoutCheckbox(y, color: nil)
        y += 75.0
        
        // ALIZARIN
        layoutCheckbox(y, color: UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0))
        y += 75.0
        
        // CAROT
        layoutCheckbox(y, color: UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1.0))
        y += 75.0
        
        // SUN FLOWER
        layoutCheckbox(y, color: UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0))
        y += 75.0
        
        // TURQUOISE
        layoutCheckbox(y, color: UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0))
        y += 75.0
        
        // EMERALD
        layoutCheckbox(y, color: UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0))
        y += 75.0
        
        // PETER RIVER
        layoutCheckbox(y, color: UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0))
        y += 75.0
        
        // AMETHYST
        layoutCheckbox(y, color: UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0))
        y += 75.0
        
        // WET ASPHALT
        layoutCheckbox(y, color: UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0))
        y += 75.0
        
        // ASBESTOS
        layoutCheckbox(y, color: UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1.0))
        y += 75.0
        
        
        scrollView.contentSize = CGSizeMake(730, y)
    }

    func layoutCheckbox(y: CGFloat, color: UIColor?) {
        
        let size: CGFloat = 50.0
        var x: CGFloat = 25.0
        
        for i in 0 ..< checkboxSizeList.count {
            let checkBoxPosition = (size - checkboxSizeList[i]) / 2
            
            let checkbox = DOCheckbox(frame: CGRectMake(x, y, size, size), checkboxFrame: CGRectMake(checkBoxPosition, checkBoxPosition, checkboxSizeList[i], checkboxSizeList[i]))
            checkbox.setPresetStyle(style, baseColor: color)
            scrollView.addSubview(checkbox)
            checkboxList.append(checkbox)
            
            x += size + checkboxSizeList[i]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //
        for checkbox in checkboxList {
            checkbox.selected = true
        }
    }
    @IBAction func toggle(sender: UIBarButtonItem) {
        if sender.title == "Check All"  {
            sender.title = "Uncheck All"
            for checkbox in checkboxList {
                checkbox.selected = true
            }
        } else {
            sender.title = "Check All"
            for checkbox in checkboxList {
                checkbox.selected = false
            }
        }
    }
}