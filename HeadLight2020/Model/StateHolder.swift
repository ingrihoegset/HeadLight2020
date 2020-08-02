//
//  StateHolder.swift
//  HeadLight2020
//
//  Created by Ingrid on 03/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation


class StateHolder {

    let best: State
    let secondBest: State
    let OK: State
    let secondWorst: State
    let worst: State

    init() {
        let dizzyness = MoreInfoObject(frame: .zero, image: "Dizzyness", title1: "Dizzyness", title2: "", moreInfoText: MoreInfoObjectTexts.dizzynessText)
        let generalDiscomfort = MoreInfoObject(frame: .zero, image: "Discomfort", title1: "General", title2: "Discomfort", moreInfoText: MoreInfoObjectTexts.generalDiscomfortText)
        let headache = MoreInfoObject(frame: .zero, image: "Headache", title1: "Headache", title2: "", moreInfoText: MoreInfoObjectTexts.headacheText)
        let eyeStrain = MoreInfoObject(frame: .zero, image: "EyeStrain", title1: "Eye", title2: "Strain", moreInfoText: MoreInfoObjectTexts.dizzynessText)
        let noSideEffect = MoreInfoObject(frame: .zero, image: "", title1: "", title2: "", moreInfoText: "")
        
        let indicatorGreen = "indicatorGreen"
        
        //Best
        let bestTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        let bestTipsObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        self.best = State(overallImageName: "Best", overallIndicatorColorMain: indicatorGreen, overallIndicatorColorSub: indicatorGreen, exposureTime: "Unlimited", indicatorTime: 100, indicatorColor: indicatorGreen, sideeffects: [dizzyness, noSideEffect, noSideEffect, noSideEffect], timerObject: [bestTimerObject], tipsObject: [bestTipsObject])
        
        //SecondBest
        self.secondBest = State(overallImageName: "Best", overallIndicatorColorMain: indicatorGreen, overallIndicatorColorSub: indicatorGreen, exposureTime: "Unlimited", indicatorTime: 100, indicatorColor: indicatorGreen, sideeffects: [], timerObject: [bestTimerObject], tipsObject: [bestTipsObject])
        
        //OK
        self.OK = State(overallImageName: "Best", overallIndicatorColorMain: indicatorGreen, overallIndicatorColorSub: indicatorGreen, exposureTime: "Unlimited", indicatorTime: 100, indicatorColor: indicatorGreen, sideeffects: [], timerObject: [bestTimerObject], tipsObject: [bestTipsObject])

        //SecondWorst
        self.secondWorst = State(overallImageName: "Best", overallIndicatorColorMain: indicatorGreen, overallIndicatorColorSub: indicatorGreen, exposureTime: "Unlimited", indicatorTime: 100, indicatorColor: indicatorGreen, sideeffects: [], timerObject: [bestTimerObject], tipsObject: [bestTipsObject])
        
        //Worst
        self.worst = State(overallImageName: "Best", overallIndicatorColorMain: indicatorGreen, overallIndicatorColorSub: indicatorGreen, exposureTime: "Unlimited", indicatorTime: 100, indicatorColor: indicatorGreen, sideeffects: [], timerObject: [bestTimerObject], tipsObject: [bestTipsObject])

    }

}
