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
        //no risk
        let noSideEffect = MoreInfoObject(frame: .zero, image: "SecondBest", title1: "No Side", title2: "Effects", moreInfoText: "This kind of lighting has no side effects.", risk: 25)
        
        //low risk
        let headacheLowRisk = MoreInfoObject(frame: .zero, image: "Headache", title1: "Headache", title2: "", moreInfoText: MoreInfoObjectTexts.lowRiskHeadache, risk: 50)
        let eyeStrainLowRisk = MoreInfoObject(frame: .zero, image: "EyeStrain", title1: "Eye", title2: "Strain", moreInfoText: MoreInfoObjectTexts.lowRiskEyeStrain, risk: 50)
        let fatigueLowRisk = MoreInfoObject(frame: .zero, image: "Discomfort", title1: "Fatigue", title2: "", moreInfoText: MoreInfoObjectTexts.lowRiskFatigue, risk: 50)
        let migraineLowRisk = MoreInfoObject(frame: .zero, image: "Migraine", title1: "Migraine", title2: "", moreInfoText: MoreInfoObjectTexts.higherRiskMigraine, risk: 50)
        let blurredVisionLowRisk = MoreInfoObject(frame: .zero, image: "Blurred", title1: "Blurred", title2: "Vision", moreInfoText: MoreInfoObjectTexts.lowRiskBlurredVision, risk: 50)
        let vertigoLowRisk = MoreInfoObject(frame: .zero, image: "Dizzyness", title1: "Vertigo", title2: "", moreInfoText: MoreInfoObjectTexts.lowRiskVertigo, risk: 50)
        
        //some risk
        let headacheSomeRisk = MoreInfoObject(frame: .zero, image: "Headache", title1: "Headache", title2: "", moreInfoText: MoreInfoObjectTexts.higherRiskHeadache, risk: 75)
        let eyeStrainSomeRisk = MoreInfoObject(frame: .zero, image: "EyeStrain", title1: "Eye", title2: "Strain", moreInfoText: MoreInfoObjectTexts.higherRiskEyeStrain, risk: 75)
        let fatigueSomeRisk = MoreInfoObject(frame: .zero, image: "Discomfort", title1: "Fatigue", title2: "", moreInfoText: MoreInfoObjectTexts.higherRiskFatigue, risk: 75)
        let migraineSomeRisk = MoreInfoObject(frame: .zero, image: "Migraine", title1: "Migraine", title2: "", moreInfoText: MoreInfoObjectTexts.higherRiskMigraine, risk: 75)
        let blurredVisionSomeRisk = MoreInfoObject(frame: .zero, image: "Blurred", title1: "Blurred", title2: "Vision", moreInfoText: MoreInfoObjectTexts.higherRiskBlurredVision, risk: 75)
        let vertigoSomeRisk = MoreInfoObject(frame: .zero, image: "Dizzyness", title1: "Vertigo", title2: "", moreInfoText: MoreInfoObjectTexts.higherRiskVertigo, risk: 75)
        
        //high risk
        let epilepticSeizure = MoreInfoObject(frame: .zero, image: "Seizure", title1: "Epileptic", title2: "Seizure", moreInfoText: "This kind of light is associated with increased risk of triggering an epileptic seizure. You should try to avoid this light.", risk: 75)
        
        let indicatorGreen = "indicatorGreen"
        
        //Best
        let bestTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "This light is good. You can spend as much time as you like in this lighting without experiencing any negative side effects.")
        let tryToLimitTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "This light is OK. You might want to limit your exposure to this lighting.")
        let limitTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "This light is bad. You should limit your exposure to this lighting.")
        let AvoidTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "This light is terrible. You should avoid this lighting.")

        //Tips
        let tip1 = MoreInfoObject(frame: .zero, image: "Introduction", title1: "", title2: "", moreInfoText: "This light is good and is not associated with increased risk of any negative side effects. Use Headlight to check other light sources in your working and living environment.")
        let tip2 = MoreInfoObject(frame: .zero, image: "LedLys", title1: "", title2: "", moreInfoText: TipsTexts.tip2)
        let tip3 = MoreInfoObject(frame: .zero, image: "Dimming", title1: "", title2: "", moreInfoText: TipsTexts.tip3)
        let tip4 = MoreInfoObject(frame: .zero, image: "FlourescentTube", title1: "", title2: "", moreInfoText: TipsTexts.tip4)
        let tip5 = MoreInfoObject(frame: .zero, image: "Bulb", title1: "", title2: "", moreInfoText: TipsTexts.tip5)
        let tip6 = MoreInfoObject(frame: .zero, image: "Curtains", title1: "", title2: "", moreInfoText: TipsTexts.tip6)
        
        
        self.best = State(
            type: "Best",
            overallTitle: "Great",
            overallImageName: "Best",
            overallIndicatorColorMain: Constants.green,
            overallIndicatorColorSub: Constants.green,
            exposureTime: "Unlimited", indicatorTime: 100,
            indicatorColor: indicatorGreen,
            sideeffects: [noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1])
        
        //SecondBest
        self.secondBest = State(
            type: "Good",
            overallTitle: "Good",
            overallImageName: "SecondBest",
            overallIndicatorColorMain: Constants.green,
            overallIndicatorColorSub: Constants.green,
            exposureTime: "Unlimited", indicatorTime: 100,
            indicatorColor: Constants.green,
            sideeffects: [noSideEffect],
            timerObject: [bestTimerObject],
            tipsObject: [tip1])
        
        //OK
        self.OK = State(
            type: "OK",
            overallTitle: "OK",
            overallImageName: "OK",
            overallIndicatorColorMain: Constants.yellow,
            overallIndicatorColorSub: Constants.yellow,
            exposureTime: "Try to limit", indicatorTime: 75,
            indicatorColor: Constants.yellow,
            sideeffects: [headacheLowRisk, eyeStrainLowRisk, blurredVisionLowRisk],
            timerObject: [tryToLimitTimerObject],
            tipsObject: [tip2, tip3, tip4, tip5, tip6])

        //SecondWorst
        self.secondWorst = State(
            type: "secondWorst",
            overallTitle: "Bad",
            overallImageName: "SecondWorst",
            overallIndicatorColorMain: Constants.red,
            overallIndicatorColorSub: Constants.red,
            exposureTime: "Limit",
            indicatorTime: 50,
            indicatorColor: Constants.red,
            sideeffects: [migraineSomeRisk, headacheSomeRisk, eyeStrainSomeRisk, blurredVisionSomeRisk],
            timerObject: [limitTimerObject],
            tipsObject: [tip2, tip3, tip4, tip5, tip6])
        
        //Worst
        self.worst = State(
            type: "Worst",
            overallTitle: "Terrible",
            overallImageName: "Worst",
            overallIndicatorColorMain: Constants.red,
            overallIndicatorColorSub: Constants.red,
            exposureTime: "Avoid",
            indicatorTime: 25,
            indicatorColor: Constants.red,
            sideeffects: [epilepticSeizure, migraineSomeRisk, headacheSomeRisk, eyeStrainSomeRisk, blurredVisionSomeRisk],
            timerObject: [AvoidTimerObject],
            tipsObject: [tip2, tip3, tip4, tip5, tip6])
    }
}
