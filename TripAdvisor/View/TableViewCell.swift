//
//  TableViewCell.swift
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import UIKit

let layoutMargin : CGFloat = 8

class TableViewCell: UITableViewCell {
    
    static func identifier() -> String{
        return String("\(TableViewCell.self)")
    }
    
    let cityImage : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "placeholder")
        v.backgroundColor = UIColor.orange
        v.heightAnchor.constraint(equalToConstant: 120).isActive = true
        v.widthAnchor.constraint(equalToConstant: 180).isActive = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let nameLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 20)
        return l
    }()
    let countryLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    let detailLabel : UILabel = {
        let l = UILabel()
        l.numberOfLines = 4
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.gray
        l.font = UIFont.systemFont(ofSize: 13)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, countryLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(cityImage)
        
        NSLayoutConstraint.activate([
            cityImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: layoutMargin),
            cityImage.topAnchor.constraint(equalTo: self.contentView.topAnchor , constant: layoutMargin),
            cityImage.trailingAnchor.constraint(equalTo: stackView.leadingAnchor , constant: -layoutMargin),
            
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor , constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: -layoutMargin),
            ])
        let constraint = cityImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -layoutMargin)
        constraint.priority = .defaultHigh
        constraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(_ city: City){
        detailLabel.text = city.description
        nameLabel.text = city.name
        countryLabel.text = city.contury
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImage.image = UIImage(named: "placeholder")
        nameLabel.text = nil
        detailLabel.text = nil
    }
}
