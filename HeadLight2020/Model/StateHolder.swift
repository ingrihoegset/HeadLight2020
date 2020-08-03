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
        let eyeStrain = MoreInfoObject(frame: .zero, image: "EyeStrain", title1: "Eye", title2: "Strain", moreInfoText: MoreInfoObjectTexts.eyeStrainText)
        let noSideEffect = MoreInfoObject(frame: .zero, image: "", title1: "", title2: "", moreInfoText: "")
        
        let indicatorGreen = "indicatorGreen"
        
        //Best
        let bestTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        let tip1 = MoreInfoObject(frame: .zero, image: "InfoBlue", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        let tip2 = MoreInfoObject(frame: .zero, image: "InfoBlue", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        let tip3 = MoreInfoObject(frame: .zero, image: "InfoBlue", title1: "", title2: "", moreInfoText: "FGHJKLKJHG")
        
        
        self.best = State(
            overallImageName: "Best",
            overallIndicatorColorMain: Constants.green,
            overallIndicatorColorSub: Constants.green,
            exposureTime: "Unlimited", indicatorTime: 100,
            indicatorColor: indicatorGreen,
            sideeffects: [noSideEffect, noSideEffect, noSideEffect, noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1, tip2, tip3])
        
        //SecondBest
        self.secondBest = State(
            overallImageName: "SecondBest",
            overallIndicatorColorMain: Constants.green,
            overallIndicatorColorSub: Constants.yellow,
            exposureTime: "Unlimited", indicatorTime: 80,
            indicatorColor: Constants.greenYellow,
            sideeffects: [eyeStrain, noSideEffect, noSideEffect, noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1, tip2, tip3])
        
        //OK
        self.OK = State(
            overallImageName: "OK",
            overallIndicatorColorMain: Constants.yellow,
            overallIndicatorColorSub: Constants.yellow,
            exposureTime: "Unlimited", indicatorTime: 50,
            indicatorColor: Constants.yellow,
            sideeffects: [eyeStrain, dizzyness, noSideEffect, noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1, tip2, tip3])

        //SecondWorst
        self.secondWorst = State(
            overallImageName: "SecondWorst",
            overallIndicatorColorMain: Constants.yellow,
            overallIndicatorColorSub: Constants.red,
            exposureTime: "Unlimited",
            indicatorTime: 20,
            indicatorColor: Constants.redYellow,
            sideeffects: [eyeStrain, dizzyness, generalDiscomfort, noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1, tip2, tip3])
        
        //Worst
        self.worst = State(
            overallImageName: "Worst",
            overallIndicatorColorMain: Constants.red,
            overallIndicatorColorSub: Constants.red,
            exposureTime: "Unlimited",
            indicatorTime: 0,
            indicatorColor: Constants.red,
            sideeffects: [eyeStrain, headache, generalDiscomfort, dizzyness],
            timerObject: [bestTimerObject],
            tipsObject: [tip1, tip2, tip3])
    }

}
