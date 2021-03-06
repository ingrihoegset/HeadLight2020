//
//  Constants.swift
//  HeadLight2020
//
//  Created by Ingrid on 22/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //Titles
    static let exposureTitle = "Exposure"
    static let sideEffectsTitle = "Possible Side Effects"
    static let tipsTitle = "Tips Title XXXX"
    
    //For analysis
    static let noOfFramesPerSecond = 240
    static let noOfFramesForAnalysis = 120
    
    //Sizes and margins
    static let widthOfDisplay = UIScreen.main.bounds.size.width
    static let heightOfDisplay = UIScreen.main.bounds.size.height
    static let displayViewPortionOfScreen = heightOfDisplay * 0.2
    static let topMargin = CGFloat(45.0)
    static let sideMargins = widthOfDisplay * 0.02
    static let verticalMargins = heightOfDisplay * 0.03
    static let cornerRadius = CGFloat(5.0)
    static let containerDimension = widthOfDisplay * 0.3
    static let smallContainerDimensions = widthOfDisplay * 0.175
    static let largeContainerDimension = widthOfDisplay * 0.4
    static let radius = Constants.containerDimension * 0.375
    
    //Colors
    static let mainColor = "mainColor"
    static let green = "indicatorGreen"
    static let red = "indicatorRed"
    static let yellow = "indicatorYellow"
    static let redYellow = "indicatorRedYellow"
    static let greenYellow = "indicatorGreenYellow"
    
}
