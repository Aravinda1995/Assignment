//
//  PLanetViewModel.swift
//  Assignment

import RxSwift
import UIKit

struct PlanetDetailViewModel {
    
    let name: String
    let gravity: String
    let orbitalPeriod: String
    var image: Observable<UIImage>

    init(planet: Planet){
        self.name = "Planet name : " + planet.name
        self.gravity = "Planet gravity : " + planet.gravity
        self.orbitalPeriod = "Planet orbital period : " + planet.orbitalPeriod
        
        self.image = PlanetService.shared.fetchPlanetImage()
    }
}
