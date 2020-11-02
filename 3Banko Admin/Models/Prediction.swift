//
//  Prediction.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import Foundation

struct Prediction {
    var date: String
    var id: Int
    
    var predict0: Predict
    var predict1: Predict
    var predict2: Predict
    
}

struct Predict {
    var uuid: String
    var dateAndTime: String
    var name: String
    var org: String
    var predict: String
    var odd: String
    var isFree: Bool
    var isOk: Bool
    var result: String
}
