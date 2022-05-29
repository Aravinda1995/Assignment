//
//  PlanetDetailViewController.swift
//  Assignment

import UIKit
import RxSwift
import RxCocoa

class PlanetDetailViewController: UIViewController {
    
    // MARK: Variables
    private let viewModel: PlanetDetailViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: UI Elements
    private let imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    private let planetNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let gravityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel: PlanetDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.settingConstraints()
        self.labelStackView.addArrangedSubview(imageView)
        self.labelStackView.addArrangedSubview(planetNameLabel)
        self.labelStackView.addArrangedSubview(orbitalPeriodLabel)
        self.labelStackView.addArrangedSubview(gravityLabel)
        
        self.settingText()
        self.settingImage()
        
    }
    
    private func settingConstraints() {
        self.view.addSubview(labelStackView)
        let guide = self.view.safeAreaLayoutGuide
        self.labelStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.labelStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.labelStackView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func settingText() {
        self.planetNameLabel.text = self.viewModel.name
        self.orbitalPeriodLabel.text = self.viewModel.orbitalPeriod
        self.gravityLabel.text = self.viewModel.gravity
    }
    
    private func settingImage() {
        self.viewModel.image.bind(to: self.imageView.rx.image).disposed(by: disposeBag)
    }

}
