//
//  Coupon.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 23.12.2020.
//

import Foundation

struct Coupon: Codable {
    let couponColumns: [CouponColumns]
}

struct CouponColumns: Codable {
    let eventId: Int
    let marketName: String
    let marketOutcomeName: String
    let odds: Double
    let eventName: String
    let eventDate: Int
}

struct MatchDetail: Codable {
    let tournament: Tournament
}

struct Tournament: Codable {
    let tournamentName: String
}
