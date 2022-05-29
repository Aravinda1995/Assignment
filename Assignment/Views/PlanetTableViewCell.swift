//
//  PlanetTableViewCell.swift
//  Assignment

import UIKit

class PlanetTableViewCell: UITableViewCell {
    static let cellReusableIdentifier = "PlanetTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: PlanetTableViewCell.cellReusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(planetCellModel: PlanetTableViewCellViewModel) {
        self.textLabel?.text = planetCellModel.name
        self.detailTextLabel?.text = planetCellModel.climate
    }
}
