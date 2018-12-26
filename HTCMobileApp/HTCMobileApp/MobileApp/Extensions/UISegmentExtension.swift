//
//  UISegmentExtension.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

import UIKit

extension UISegmentedControl {
    static let bg  = UIColor(red:   0.0/255, green: 190.0/255, blue: 255.0/255, alpha: 1.0)
    
    func removeBorder() {
        let backgroundImage = UIImage.getColoredRectImageWith(color:  UIColor(red:   0.0/255, green: 190.0/255, blue: 255.0/255, alpha: 1.0).cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor,
                                                           andSize: CGSize(width: 0.00001, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected,
                             rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.white], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.white], for: .selected)
    }
    
    func addUnderlineForSelectedSegment() {
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height
        let underlineFrame = CGRect(x: underlineXPosition,
                                    y: underLineYPosition,
                                    width: underlineWidth,
                                    height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = Colours.frenchBlue
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition() {
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition =
            (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage {
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
