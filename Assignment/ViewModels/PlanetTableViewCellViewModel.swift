//
//  PlanetTableViewCellViewModel.swift
//  Assignment

struct PlanetTableViewCellViewModel {
    let climate: String
    let name: String

    init(planet: Planet){
        self.climate = planet.climate
        self.name = planet.name
    }
}
