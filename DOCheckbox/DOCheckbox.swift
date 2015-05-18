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
    case Default
    case Square
    case FilledSquare
    case RoundedSquare
    case FilledRoundedSquare
    case Circle
    case FilledCircle
}

class DOCheckbox: UIButton {
    
    private var style: DOCheckboxStyle! = .Default
    private var baseColor: UIColor = UIColor.blackColor()
    
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
            checkBgLayer.frame = checkboxFrame
            
            // default setting
            setPresetStyle(style, baseColor: baseColor)
        }
    }
    var checkboxBorderWidth: CGFloat! = 0.0 {
        didSet {
            checkboxLayer.borderWidth = checkboxBorderWidth
            let rectCornerRadius = (checkboxCornerRadius > checkboxBorderWidth / 2) ? checkboxCornerRadius - checkboxBorderWidth / 2 : 0
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), rectCornerRadius, rectCornerRadius, nil)
        }
    }
    var checkboxCornerRadius: CGFloat! = 0.0 {
        didSet {
            checkboxLayer.cornerRadius = checkboxCornerRadius
            let rectCornerRadius = (checkboxCornerRadius > checkboxBorderWidth / 2) ? checkboxCornerRadius - checkboxBorderWidth / 2 : 0
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), rectCornerRadius, rectCornerRadius, nil)
        }
    }
    var checkWidth: CGFloat! {
        didSet {
            checkLayer.lineWidth = checkWidth
            checkLayer.miterLimit = checkWidth
            checkBgLayer.lineWidth = checkWidth
            checkBgLayer.miterLimit = checkWidth
        }
    }
    var checkboxBgColor: UIColor! {
        didSet { checkboxLayer.fillColor = checkboxBgColor.CGColor }
    }
    var checkboxBorderColor: UIColor! {
        didSet { checkboxLayer.borderColor = checkboxBorderColor.CGColor }
    }
    var checkColor: UIColor! {
        didSet { checkLayer.strokeColor = checkColor.CGColor }
    }
    var checkBgColor: UIColor! {
        didSet { checkBgLayer.strokeColor = checkBgColor.CGColor }
    }
    
    private(set) var ratio: CGFloat = 1.0
    let checkboxLayer: CAShapeLayer! = CAShapeLayer()
    let checkLayer: CAShapeLayer! = CAShapeLayer()
    let checkBgLayer: CAShapeLayer! = CAShapeLayer()
    
    override var selected: Bool {
        didSet {
            if (selected != oldValue) {
                let strokeStart = CABasicAnimation(keyPath: "strokeStart")
                let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
                if self.selected {
                    // check animation
                    strokeStart.fromValue = 0.0
                    strokeStart.toValue = 0.0
                    strokeStart.duration = 0.1
                    strokeEnd.fromValue = 0.0
                    strokeEnd.toValue = 1.0
                    strokeEnd.duration = 0.1
                } else {
                    // uncheck animation
                    strokeStart.fromValue = 0.0
                    strokeStart.toValue = 1.0
                    strokeStart.duration = 0.1
                    strokeEnd.fromValue = 1.0
                    strokeEnd.toValue = 1.0
                    strokeEnd.duration = 0.1
                    strokeEnd.fillMode = kCAFillModeBackwards
                }
                self.checkLayer.ocb_applyAnimation(strokeStart)
                self.checkLayer.ocb_applyAnimation(strokeEnd)
            }
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
        
        // background check
        checkBgLayer.fillColor = nil
        checkBgLayer.masksToBounds = true
        checkBgLayer.strokeStart = 0.0
        checkBgLayer.strokeEnd = 1.0
        self.layer.addSublayer(checkBgLayer)
        
        // check
        checkLayer.fillColor = nil
        checkLayer.masksToBounds = true
        checkLayer.actions = ["strokeStart": NSNull(), "strokeEnd": NSNull()]
        checkLayer.strokeStart = 0.0
        checkLayer.strokeEnd = 0.0
        self.layer.addSublayer(checkLayer)
        
        // add target for TouchUpInside event
        self.addTarget(self, action: "toggleSelected:", forControlEvents:.TouchUpInside)
    }
    
    func toggleSelected(sender: AnyObject) {
        self.selected = !self.selected
    }
    
    func setPresetStyle(style: DOCheckboxStyle?, baseColor: UIColor?) {
        if (style != nil) {
            self.style = style!
        }
        if (baseColor != nil) {
            self.baseColor = baseColor!
        }
        
        // checkbox style
        switch (self.style!) {
        case .Default:
            checkboxBorderWidth = 0
            checkboxCornerRadius = 0
            
        case .Square, .FilledSquare:
            checkboxBorderWidth = round(5 * ratio * 10) / 10
            checkboxCornerRadius = 0
            
        case .RoundedSquare, .FilledRoundedSquare:
            checkboxBorderWidth = round(5 * ratio * 10) / 10
            checkboxCornerRadius = round(15 * ratio * 10) / 10
            
        case .Circle, .FilledCircle:
            checkboxBorderWidth = round(5 * ratio * 10) / 10
            checkboxCornerRadius = round(50 * ratio * 10) / 10
        }
        
        // check style
        switch (self.style!) {
        case .Default, .Square, .FilledSquare, .RoundedSquare, .FilledRoundedSquare, .Circle, .FilledCircle:
            checkWidth = round(15 * ratio * 10) / 10
            checkBgLayer.path = {
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 27 * self.ratio, 53 * self.ratio)
                CGPathAddLineToPoint(path, nil, 42 * self.ratio, 68 * self.ratio)
                CGPathAddLineToPoint(path, nil, 75 * self.ratio, 34 * self.ratio)
                return path
                }()
            checkBgLayer.lineCap = kCALineCapSquare
            checkBgLayer.lineJoin = kCALineJoinMiter
            checkLayer.path = {
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 27 * self.ratio, 53 * self.ratio)
                CGPathAddLineToPoint(path, nil, 42 * self.ratio, 68 * self.ratio)
                CGPathAddLineToPoint(path, nil, 75 * self.ratio, 34 * self.ratio)
                return path
                }()
            checkLayer.lineCap = kCALineCapSquare
            checkLayer.lineJoin = kCALineJoinMiter
        }
        
        // color
        switch (self.style!) {
        case .Default, .Square, .RoundedSquare, .Circle:
            checkboxBgColor = UIColor.whiteColor()
            checkboxBorderColor = self.baseColor
            checkColor = self.baseColor
            checkBgColor = convertColor(self.baseColor, toColor: UIColor.whiteColor(), percent: 0.85)
            
        case .FilledSquare, .FilledRoundedSquare, .FilledCircle:
            checkboxBgColor = self.baseColor
            checkboxBorderColor = self.baseColor
            checkColor = UIColor.whiteColor()
            checkBgColor = convertColor(self.baseColor, toColor: UIColor.whiteColor(), percent: 0.3)
        }
    }
    
    func convertColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var a1: CGFloat = 0.0
        fromColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a2: CGFloat = 0.0
        toColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r: CGFloat = r1 + (r2 - r1) * percent
        let g: CGFloat = g1 + (g2 - g1) * percent
        let b: CGFloat = b1 + (b2 - b1) * percent
        let a: CGFloat = a1 + (a2 - a1) * percent
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
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