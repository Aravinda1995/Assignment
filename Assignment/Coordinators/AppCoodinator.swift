//
//  AppCoodinator.swift
//  Assignment

import UIKit

enum Event {
    case cellSelected(Planet)
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
    func eventOccured(with type: Event)
}

protocol Coordinating {
    var coordinator: Coordinator { get }
}

class PlanetAppCoordinator : Coordinator {

    var navigationController: UINavigationController?

    /// Sets PlanetViewController to the navigation controller
    func start() {
        let viewController: UIViewController & Coordinating = PlanetListViewController(viewModel: PlanetListViewModel(), coordinator: self)
        navigationController?.setViewControllers([viewController], animated: false)
    }

    func eventOccured(with type: Event){
        switch type {
        case .cellSelected(let planet):
            let model = PlanetDetailViewModel(planet: planet)
            let viewController: PlanetDetailViewController = PlanetDetailViewController(viewModel: model)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

