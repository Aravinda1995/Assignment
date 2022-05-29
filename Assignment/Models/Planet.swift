//
//  PlanetModel.swift
//  Assignment

import Foundation

/// Data Model returned from API
struct DataModel: Codable {
    let count: Int
    let next: String
    let results: [Planet]
}

/// Data Model of the Planet
struct Planet: Codable {
    let name: String
    let orbitalPeriod: String
    let climate: String
    let gravity: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case climate, gravity
    }
}
