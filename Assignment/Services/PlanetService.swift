//
//  PlanetService.swift
//  Assignment

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol PlanetServiceProtocol {
    func fetchPlanets<T: Codable>(_ pageNo: Int) -> Observable<(T?, Int)>
}

class PlanetService : PlanetServiceProtocol {
    
    static let shared = PlanetService()
    
    private let session = URLSession(configuration: .default)
    private var task: URLSessionDataTask? = nil
    
    private init() {}
    
    func fetchPlanets<T: Codable>(_ pageNo: Int) -> Observable<(T?,Int)> {
        guard let url = URL(string: "https://swapi.dev/api/planets/?page=\(pageNo)") else {
            return .never()
        }
        
        return Observable<(T?,Int)>.create { observer in
            self.task = self.session.dataTask(with: url) { (data,response,error) in
                guard let data = data else {
                    return
                }
                
                do {
                    let model: DataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    
                    observer.onNext((model.results as? T, model.count))
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            
            self.task?.resume()
            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
    
    func fetchPlanetImage() -> Observable<UIImage> {
        guard let url = URL(string: "https://picsum.photos/150/150") else {
            return .never()
        }
        
        return Observable<UIImage>.create { observer in
            self.task = self.session.dataTask(with: url) { (data,response,error) in
                guard let data = data, let image = UIImage(data: data)  else {
                    return
                }
                
                observer.onNext(image)
               
                observer.onCompleted()
            }
            self.task?.resume()
            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
}
