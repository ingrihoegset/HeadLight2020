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
    
    //Fonts
    static let readingFont = UIFont(name: "Poppins-Light", size: 18)
    static let pageHeaderFont = UIFont(name: "Poppins-Light", size: 24)
    static let logoFont = UIFont(name: "GrandHotel-Regular", size: 28)
    
    //Titles
    static let exposureTitle = "Exposure"
    static let sideEffectsTitle = "Possible Side Effects"
    static let tipsTitle = "Tips Title XXXX"
    
    //For analysis
    static let noOfFramesPerSecond = 240
    static let noOfFramesForAnalysis = 240
    
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
    static let largeContainerDimension = heightOfDisplay * 0.225
    static let radius = Constants.containerDimension * 0.375
    static let radiusContainers = Constants.containerDimension * 0.225
    static let trackLayerLineWidth = CGFloat(8)
    static let seperator = widthOfDisplay * 0.03
    
    //Colors
    static let mainColor = "mainColor"
    static let green = "indicatorGreen"
    static let red = "indicatorRed"
    static let yellow = "indicatorYellow"
    static let redYellow = "indicatorRedYellow"
    static let greenYellow = "indicatorGreenYellow"
    
    //Page titles
    static let howTo = "How to use"
    
}
