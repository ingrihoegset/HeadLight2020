//
//  Result.swift
//  HeadLight2020
//
//  Created by Ingrid on 10/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//


import Foundation

class Result {
    
    var hertz: Int
    var value: Float
    var lumosity: Float
    
    init(lumosity: Float, hertz: Int, value: Float) {
        self.lumosity = lumosity
        self.hertz = hertz
        self.value = value
    }
    
    init(hertz: Int, value: Float) {
        lumosity = 0
        self.hertz = hertz
        self.value = value
    }
}
