//
//  CharityDataProvider.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import Foundation
import CSV
import CoreLocation

class CharityDataProvider {
    
    private(set) static var charities: [Charity] = []
    
    private init() {}
    
    static func load() {
        let userDefaultsCharities = loadFromUserDefaults()
        if userDefaultsCharities.isEmpty {
            CharityDataProvider.charities = loadFromCSV()
        } else {
            CharityDataProvider.charities = userDefaultsCharities
        }
    }
    
    static func save() {
        let data = try! JSONEncoder().encode(charities)
        UserDefaults.standard.set(data, forKey: "charities")
    }
    
    private static func loadFromUserDefaults() -> [Charity] {
        guard let charities = UserDefaults.standard.data(forKey: "charities") else {
            return []
        }
        return try! JSONDecoder().decode([Charity].self, from: charities)
    }
    
    private static func loadFromCSV() -> [Charity] {
        guard let csvURL = Bundle.main.url(forResource: "locationdata", withExtension: "csv"),
        let stream = InputStream(url: csvURL),
        let csv = try? CSVReader(stream: stream, hasHeaderRow: true) else {
            return []
        }
        var charities: [Charity] = []
        while let row = csv.next() {
            charities.append(
                Charity(key: row[0],
                        name: row[1],
                        coordinate: CLLocationCoordinate2D(
                            latitude: Double(row[2])!,
                            longitude: Double(row[3])!
                        ),
                        address: row[4],
                        city: row[5],
                        state: row[6],
                        zip: Int(row[7])!,
                        type: CharityType(csvString: row[8])!,
                        phoneNumber: row[9],
                        website: row[10],
                        donations: []
                )
            )
        }
        return charities
    }
    
}
