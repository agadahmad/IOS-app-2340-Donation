//
//  Donation.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import Foundation

enum DonationType: Int, Codable {
    case clothing, hat, kitchen, electronics, household, other
    static let values: [DonationType] = [.clothing, .hat, .kitchen, .electronics, .household, .other]
    var name: String {
        switch self {
        case .clothing:
            return "Clothing"
        case .hat:
            return "Hat"
        case .kitchen:
            return "Kitchen"
        case .electronics:
            return "Electronics"
        case .household:
            return "Household"
        case .other:
            return "Other"
        }
    }
}

class Donation: Codable {
    let date: Date
    let zip: String
    let description: String
    let amount: Double
    let type: DonationType
    init(date: Date,
    zip: String,
    description: String,
    amount: Double,
    type: DonationType) {
        self.date = date
        self.zip = zip
        self.description = description
        self.amount = amount
        self.type = type
    }
}
