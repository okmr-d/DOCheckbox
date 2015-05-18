//
//  ViewController.swift
//  DOCheckbox
//
//  Created by Daiki Okumura on 2015/05/16.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//

import UIKit

class ParentViewController: UITableViewController, UITextFieldDelegate  {
    
    var style: DOCheckboxStyle = .Default
    
    var actionMap: [[(selectedIndexPath: NSIndexPath) -> Void]] {
        return [
            // Alert style alerts.
            [
                self.showDefault,
                self.showSquare,
                self.showSquareFill,
                self.showRoundedSquare,
                self.showRoundedSquareFill,
                self.showCircle,
                self.showCircleFill
            ],
            // Action sheet style alerts.
            [
                self.showSquare
            ]
        ]
    }
    
    func showDefault(_: NSIndexPath) {
        self.style = .Default
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showSquare(_: NSIndexPath) {
        self.style = .Square
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showSquareFill(_: NSIndexPath) {
        self.style = .FilledSquare
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showRoundedSquare(_: NSIndexPath) {
        self.style = .RoundedSquare
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showRoundedSquareFill(_: NSIndexPath) {
        self.style = .FilledRoundedSquare
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showCircle(_: NSIndexPath) {
        self.style = .Circle
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    func showCircleFill(_: NSIndexPath) {
        self.style = .FilledCircle
        self.performSegueWithIdentifier("showChildView", sender:self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showChildView") {
            let childViewController = segue.destinationViewController as! ChildViewController
            childViewController.style = self.style
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        }
    }
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let action = actionMap[indexPath.section][indexPath.row]
        
        action(selectedIndexPath: indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
