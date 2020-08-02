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
    static let topMargin = heightOfDisplay * 0.1
    static let sideMargins = widthOfDisplay * 0.02
    static let verticalMargins = heightOfDisplay * 0.03
    static let cornerRadius = CGFloat(5.0)
    static let containerDimension = widthOfDisplay * 0.3
    static let smallContainerDimensions = widthOfDisplay * 0.175
    static let largeContainerDimension = widthOfDisplay * 0.4
    static let radius = Constants.containerDimension * 0.375
    
    static let stateBest = [
                            //Overall results panel - Image - Animation Color 1 - Animation Color 2
                            "Best",
                            "indicatorGreen",
                            "indicatorGreen",
                            
                            //Timer panel - Timer result - Indicator end - Indicator Color
                            "Unlimited",
                            "100",
                            "indicatorGreen",
                            
                            //Side effect 1 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 2 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 3 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 4 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            ""
    ]
    
    static let stateSecondBest = [
                            //Overall results panel - Image - Animation Color 1 - Animation Color 2
                            "SecondBest",
                            "indicatorGreen",
                            "mainContrastColor",
                            
                            //Timer panel - Timer result - Indicator end - Indicator Color
                            "12 hours",
                            "80",
                            "indicatorGreenYellow",
                            
                            //Side effect 1 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "EyeStrain",
                            "Eye",
                            "Strain",
                            //Side effect 2 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 3 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 4 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            ""
    ]
    
    static let stateOK = [
                            //Overall results panel - Image - Animation Color 1 - Animation Color 2
                            "OK",
                            "mainContrastColor",
                            "mainContrastColor",
                            
                            //Timer panel - Timer result - Indicator end - Indicator Color
                            "4 hours",
                            "35",
                            "mainContrastColor",
                            
                            //Side effect 1 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "EyeStrain",
                            "Eye",
                            "Strain",
                            //Side effect 2 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 3 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 4 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            ""
    ]
    
    static let stateSecondWorst = [
                            //Overall results panel - Image - Animation Color 1 - Animation Color 2
                            "SecondWorst",
                            "indicatorRed",
                            "mainContrastColor",
                            
                            //Timer panel - Timer result - Indicator end - Indicator Color
                            "2 hours",
                            "25",
                            "indicatorRedYellow",
                            
                            //Side effect 1 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "EyeStrain",
                            "Eye",
                            "Strain",
                            //Side effect 2 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "Discomfort",
                            "General",
                            "Discomfort",
                            //Side effect 3 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            "",
                            //Side effect 4 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "Clear",
                            "",
                            "",
                            ""
    ]
    
    static let stateWorst = [
                            //Overall results panel - Image - Animation Color 1 - Animation Color 2
                            "Worst",
                            "indicatorRed",
                            "indicatorRed",
                            
                            //Timer panel - Timer result - Indicator end - Indicator Color
                            "15 min",
                            "10",
                            "indicatorRed",
                            
                            //Side effect 1 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "EyeStrain",
                            "Eye",
                            "Strain",
                            //Side effect 2 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "Headache",
                            "Headache",
                            "",
                            //Side effect 3 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "Discomfort",
                            "General",
                            "Discomfort",
                            //Side effect 4 - Backgroundcolor - Image - Undertitle 1 - Undertitle 2
                            "accentLight",
                            "Dizzyness",
                            "Dizzyness",
                            ""
    ]

}
