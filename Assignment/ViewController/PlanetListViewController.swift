//
//  PlanetListViewController.swift
//  Assignment

import UIKit
import RxSwift
import RxCocoa

class PlanetListViewController: UIViewController, Coordinating {
    
    // MARK: Variables
    let coordinator: Coordinator
    private let viewModel: PlanetListViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: UI Elements
    lazy var planetTableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlanetTableViewCell.self, forCellReuseIdentifier: PlanetTableViewCell.cellReusableIdentifier)
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel: PlanetListViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(planetTableView)
        self.navigationItem.title = viewModel.title
        self.buildUI()
        
        self.viewModel.loadPlanets.onNext(0)
    }
    
    func buildUI() {
    
        planetTableView.tableFooterView = UIView()
        
        viewModel.planetList
            .asObservable()
            .bind(to: planetTableView.rx.items(cellIdentifier: PlanetTableViewCell.cellReusableIdentifier, cellType: PlanetTableViewCell.self)) { row, planet, cell in
            let model = PlanetTableViewCellViewModel(planet: planet)
            cell.configureCell(planetCellModel: model)
        
        }.disposed(by: disposeBag)
        
        planetTableView.rx.willDisplayCell.asObservable().subscribe { _, indexPath in
            if indexPath.row != 0 {
                self.viewModel.loadPlanets.onNext(indexPath.row)
            }
        }.disposed(by: disposeBag)
        
        planetTableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
            self.planetTableView.deselectRow(at: indexPath, animated: true)
            let planet = self.viewModel.planetList.value[indexPath.row]
            
            self.coordinator.eventOccured(with: .cellSelected(planet))
        }).disposed(by: disposeBag)
    }
}
