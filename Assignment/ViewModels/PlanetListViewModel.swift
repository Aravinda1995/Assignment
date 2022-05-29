//
//  PlanetListViewModel.swift
//  Assignment

import RxSwift
import RxCocoa

class PlanetListViewModel {
    let title = "Planets"
    
    let planetList = BehaviorRelay<[Planet]>(value: [])
    let loadPlanets = PublishSubject<Int>()
    private var totalcount: Int = 0
    private let pageSize = 10
    
    private let disposeBag = DisposeBag()

    init() {

        loadPlanets
            .filter({ self.totalcount == 0 || (($0 + 1) >= self.planetList.value.count && $0 + 1 < self.totalcount) })
            .map({ (($0 + 1) / self.pageSize) + 1 })
            .subscribe(onNext: { pageNo in
            
            let response: Observable<([Planet]?, Int)> = PlanetService.shared.fetchPlanets(pageNo)
            
            response.subscribe(onNext: {[weak self] response in
                guard let self = self, let newPlanets = response.0 else {
                    return
                }
                
                self.totalcount = response.1
                let planetArray = self.planetList.value + newPlanets
                self.planetList.accept(planetArray)
            }, onError: { (error) in
                print(error)
                _ = self.planetList.catch {(error) in
                    Observable.never()
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
