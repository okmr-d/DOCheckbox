//
//  DOCheckbox.swift
//  DOCheckbox
//
//  Created by Daiki Okumura on 2015/05/16.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

enum DOCheckboxStyle : Int {
    case Default // RoundedRect
    case RoundedRect
    case Rect
}

class DOCheckbox: UIButton {
    
    var style: DOCheckboxStyle! = .Default
    
    var checkboxFrame: CGRect! {
        didSet {
            // reset checkbox
            
            let ratioW = checkboxFrame.width / 100.0
            let ratioH = checkboxFrame.height / 100.0
            ratio = (ratioW > ratioH) ? ratioH : ratioW
            let checkboxSize: CGFloat = (ratioW > ratioH) ? checkboxFrame.height : checkboxFrame.width
            
            checkboxFrame = CGRectMake(checkboxFrame.origin.x, checkboxFrame.origin.y, checkboxSize, checkboxSize)
            checkboxLayer.frame = checkboxFrame
            
            checkLayer.frame = checkboxFrame
            
            // default setting
            checkLayer.path = {
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 27 * self.ratio, 53 * self.ratio)
                CGPathAddLineToPoint(path, nil, 42 * self.ratio, 68 * self.ratio)
                CGPathAddLineToPoint(path, nil, 75 * self.ratio, 34 * self.ratio)
                return path
                }()
            checkboxBackgroundColor = UIColor.whiteColor()
            checkboxBorderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
            checkboxBorderWidth = 5 * ratio
            checkboxCornerRadius = 15 * ratio
            checkColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
            checkWidth = 15 * ratio
        }
    }
    var checkboxBorderWidth: CGFloat! = 0.0 {
        didSet {
            println("checkboxBorderWidth didSet")
            checkboxLayer.borderWidth = checkboxBorderWidth
            let rectCornerRadius = (checkboxCornerRadius > checkboxBorderWidth / 2) ? checkboxCornerRadius - checkboxBorderWidth / 2 : 0
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), rectCornerRadius, rectCornerRadius, nil)
        }
    }
    var checkboxCornerRadius: CGFloat! = 0.0 {
        didSet {
            println("checkboxCornerRadius didSet")
            checkboxLayer.cornerRadius = checkboxCornerRadius
            let rectCornerRadius = (checkboxCornerRadius > checkboxBorderWidth / 2) ? checkboxCornerRadius - checkboxBorderWidth / 2 : 0
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), rectCornerRadius, rectCornerRadius, nil)
        }
    }
    var checkWidth: CGFloat! {
        didSet {
            checkLayer.lineWidth = checkWidth
            checkLayer.miterLimit = checkWidth
        }
    }
    var checkboxBackgroundColor: UIColor! {
        didSet {
            checkboxLayer.fillColor = checkboxBackgroundColor.CGColor
        }
    }
    var checkboxBorderColor: UIColor! {
        didSet {
            checkboxLayer.borderColor = checkboxBorderColor.CGColor
        }
    }
    var checkColor: UIColor! {
        didSet {
            checkLayer.strokeColor = checkColor.CGColor
        }
    }
    
    private(set) var ratio: CGFloat = 1.0
    let checkLayer: CAShapeLayer! = CAShapeLayer()
    let checkboxLayer: CAShapeLayer! = CAShapeLayer()
    
    override var selected: Bool {
        didSet {
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            if self.selected {
                strokeEnd.toValue = 1.0
                strokeEnd.duration = 0.1
            } else {
                strokeEnd.toValue = 0.0
                strokeEnd.duration = 0.1
                strokeEnd.fillMode = kCAFillModeBackwards
            }
            self.checkLayer.ocb_applyAnimation(strokeEnd)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout(frame, checkboxFrame: CGRectMake(0, 0, frame.width, frame.height))
    }
    
    init(frame: CGRect, checkboxFrame: CGRect) {
        super.init(frame: frame)
        layout(frame, checkboxFrame: checkboxFrame)
    }
    
    func layout(frame: CGRect, checkboxFrame: CGRect) {
        
        // checkbox
        self.checkboxFrame = checkboxFrame
        checkboxLayer.masksToBounds = true
        self.layer.addSublayer(checkboxLayer)
        
        // check
        checkLayer.fillColor = nil
        checkLayer.lineCap = kCALineCapSquare //kCALineCapRound
        checkLayer.lineJoin = kCALineJoinMiter //kCALineJoinRound
        checkLayer.masksToBounds = true
        checkLayer.actions = ["strokeEnd": NSNull()]
        checkLayer.strokeStart = 0.0
        checkLayer.strokeEnd = 0.0
        self.layer.addSublayer(checkLayer)
        
        // add target for TouchUpInside event
        self.addTarget(nil, action: "switchSelected", forControlEvents:.TouchUpInside)
    }
    
    // switch selected
    func switchSelected() {
        self.selected = !self.selected
    }
}

extension CALayer {
    func ocb_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer().valueForKeyPath(copy.keyPath)
        }
        
        self.addAnimation(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath)
    }
}