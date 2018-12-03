//
//  Charity.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

enum CharityType: String, Codable {
    case dropOff, store, warehouse
    init?(csvString: String) {
        switch csvString {
        case "Drop Off":
            self = .dropOff
        case "Store":
            self = .store
        case "Warehouse":
            self = .warehouse
        default:
            return nil
        }
    }
}

extension CLLocationCoordinate2D: Codable {
    enum Key: CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let latitude = try! container.decode(Double.self, forKey: .latitude)
        let longitude = try! container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try! container.encode(latitude, forKey: .latitude)
        try! container.encode(longitude, forKey: .longitude)
    }
}

class Charity: NSObject, Codable, MKAnnotation {
    let key: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let city: String
    let state: String
    let zip: Int
    let type: CharityType
    let phoneNumber: String
    let website: String
    var donations: [Donation]
    
    var title: String? {
        return name
    }
    var subtitle: String? {
        return phoneNumber
    }
    
    init(key: String,
    name: String,
    coordinate: CLLocationCoordinate2D,
    address: String,
    city: String,
    state: String,
    zip: Int,
    type: CharityType,
    phoneNumber: String,
    website: String,
    donations: [Donation]) {
        self.key = key
        self.name = name
        self.coordinate = coordinate
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.type = type
        self.phoneNumber = phoneNumber
        self.website = website
        self.donations = donations
        super.init()
    }
}
