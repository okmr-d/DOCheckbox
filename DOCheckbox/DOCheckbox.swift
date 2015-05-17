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

class DOCheckbox: UIButton {
    
    var checkboxFrame: CGRect! {
        didSet {
            println("checkboxFrame didSet")
            
            let ratioW = checkboxLayer.frame.width / 100.0
            let ratioH = checkboxLayer.frame.height / 100.0
            ratio = (ratioW > ratioH) ? ratioH : ratioW
            let checkboxSize: CGFloat = (ratioW > ratioH) ? checkboxFrame.height : checkboxFrame.width
            
            checkboxFrame = CGRectMake(checkboxFrame.origin.x, checkboxFrame.origin.y, checkboxSize, checkboxSize)
            checkboxLayer.frame = checkboxFrame

            checkboxCornerRadius = 0.0
            checkboxBorderWidth = 0.0
            
            checkLayer.frame = checkboxFrame
            checkLayer.path = {
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 27 * self.ratio, 53 * self.ratio)
                CGPathAddLineToPoint(path, nil, 42 * self.ratio, 68 * self.ratio)
                CGPathAddLineToPoint(path, nil, 75 * self.ratio, 34 * self.ratio)
                return path
                }()
            
            checkWidth = 15 * ratio
        }
    }
    var checkboxCornerRadius: CGFloat! = 0.0 {
        didSet {
            println("checkboxCornerRadius didSet")
            checkboxLayer.cornerRadius = checkboxCornerRadius
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), checkboxCornerRadius - checkboxBorderWidth / 2, checkboxCornerRadius - checkboxBorderWidth / 2, nil)
        }
    }
    var checkboxBorderWidth: CGFloat! = 0.0 {
        didSet {
            println("checkboxBorderWidth didSet")
            checkboxLayer.borderWidth = checkboxBorderWidth
            checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(checkboxBorderWidth / 2, checkboxBorderWidth / 2, checkboxFrame.width - checkboxBorderWidth, checkboxFrame.height - checkboxBorderWidth), checkboxCornerRadius - checkboxBorderWidth / 2, checkboxCornerRadius - checkboxBorderWidth / 2, nil)
        }
    }
    var checkWidth: CGFloat! {
        didSet {
            println("checkWidth didSet")
            checkLayer.lineWidth = checkWidth
            checkLayer.miterLimit = checkWidth
        }
    }
    var checkboxBackgroundColor: UIColor! {
        didSet {
            println("checkboxBackgroundColor didSet")
            checkboxLayer.fillColor = checkboxBackgroundColor.CGColor
        }
    }
    var checkboxBorderColor: UIColor! {
        didSet {
            println("checkboxBorderColor didSet")
            checkboxLayer.borderColor = checkboxBorderColor.CGColor
        }
    }
    var checkColor: UIColor! {
        didSet {
            println("checkColor didSet")
            checkLayer.strokeColor = checkColor.CGColor
            println(checkColor)
        }
    }
    
    let checkStrokeStart: CGFloat = 0.0
    let checkStrokeEnd: CGFloat = 1.0
    let uncheckStrokeStart: CGFloat = 0.0
    let uncheckStrokeEnd: CGFloat = 0.0
    
    let checkLayer: CAShapeLayer! = CAShapeLayer()
    let checkboxLayer: CAShapeLayer! = CAShapeLayer()
    private var ratio: CGFloat = 1.0
    
    override var selected: Bool {
        didSet {
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            if self.selected {
                strokeEnd.toValue = checkStrokeEnd
                strokeEnd.duration = 0.15
            } else {
                strokeEnd.toValue = uncheckStrokeEnd
                strokeEnd.duration = 0.15
                strokeEnd.fillMode = kCAFillModeBackwards
            }
            self.checkLayer.ocb_applyAnimation(strokeEnd)
            println("\(selected)")
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience override init(frame: CGRect) {
        self.init(frame: frame, checkboxFrame: CGRectMake(0, 0, frame.width, frame.height))
    }
    
    init(frame: CGRect, checkboxFrame: CGRect) {
        super.init(frame: frame)
        
        let ratioW = checkboxFrame.width / 100.0
        let ratioH = checkboxFrame.height / 100.0
        ratio = (ratioW > ratioH) ? ratioH : ratioW
        let checkboxSize: CGFloat = (ratioW > ratioH) ? checkboxFrame.height : checkboxFrame.width
        
        /** checkboxLayer **/
        self.checkboxFrame = CGRectMake(checkboxFrame.origin.x, checkboxFrame.origin.y, checkboxSize, checkboxSize)
        checkboxLayer.frame = self.checkboxFrame
        
        checkboxCornerRadius = 0.0
        checkboxLayer.cornerRadius = checkboxCornerRadius
        
        checkboxBorderWidth = 0.0
        checkboxLayer.borderWidth = checkboxBorderWidth
        
        checkboxLayer.path = CGPathCreateWithRoundedRect(CGRectMake(0, 0, self.checkboxFrame.width, self.checkboxFrame.height), 0, 0, nil)
        
        checkboxBackgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
        checkboxLayer.fillColor = checkboxBackgroundColor.CGColor
        
        checkboxBorderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
        checkboxLayer.borderColor = checkboxBorderColor.CGColor
        
        checkboxLayer.masksToBounds = true
        
        self.layer.addSublayer(checkboxLayer)
        
        /** checkLayer **/
        checkLayer.frame = self.checkboxFrame
        checkLayer.path = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 27 * self.ratio, 53 * self.ratio)
            CGPathAddLineToPoint(path, nil, 42 * self.ratio, 68 * self.ratio)
            CGPathAddLineToPoint(path, nil, 75 * self.ratio, 34 * self.ratio)
            return path
            }()
        
        checkLayer.fillColor = nil
        
        checkColor = UIColor.whiteColor()
        checkLayer.strokeColor = checkColor.CGColor
        
        checkWidth = 15 * ratio
        checkLayer.lineWidth = checkWidth
        checkLayer.miterLimit = checkWidth
        
        checkLayer.lineCap = kCALineCapSquare //kCALineCapRound
        checkLayer.lineJoin = kCALineJoinMiter //kCALineJoinRound
        
        checkLayer.masksToBounds = true
        
        checkLayer.actions = ["strokeEnd": NSNull()]
        
        checkLayer.strokeStart = uncheckStrokeStart
        checkLayer.strokeEnd = uncheckStrokeEnd
        
        self.layer.addSublayer(checkLayer)
        
        self.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
    }
    
    func toggle(sender: UIButton!) {
        sender.selected = !sender.selected
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