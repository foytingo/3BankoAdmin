//
//  Prediction.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import Foundation

struct Prediction {
    let date: String
    let id: Int
    
    let predict1: Predict
    let predict2: Predict
    let predict3: Predict
    
}

struct Predict {
    let uuid: String
    let dateAndTime: String
    let name: String
    let org: String
    let predict: String
    let odd: String
    let isFree: Bool
    let isOk: Bool
    let result: String
}
