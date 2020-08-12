//
//  State.swift
//  HeadLight2020
//
//  Created by Ingrid on 03/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation

struct State {
    
    let overallTitle: String?
    let overallImageName: String?
    let overallIndicatorColorMain: String?
    let overallIndicatorColorSub: String?
    
    let exposureTime: String?
    let indicatorTime: Int?
    let indicatorColor: String?
    
    let sideeffects: [MoreInfoObject]?
    let timerObject: [MoreInfoObject]?
    let tipsObject: [MoreInfoObject]?
    
}
