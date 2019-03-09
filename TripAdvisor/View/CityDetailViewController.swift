//
//  CityDetailViewController.swift
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import UIKit

class CityDetailViewController: UIViewController {
    let city : City
    var dataManager : CityDataManager
    
    let cityImage : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "placeholder")
         v.clipsToBounds = true
        v.backgroundColor = UIColor.orange
        v.heightAnchor.constraint(equalToConstant: 240).isActive = true
        v.widthAnchor.constraint(equalToConstant: 360).isActive = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let nameLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 25)
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
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.gray
        l.font = UIFont.systemFont(ofSize: 13)
        return l
    }()
    
    let scrollView : UIScrollView = {
        let v = UIScrollView()
        v.alwaysBounceVertical = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    init(_ city: City, _ dataManager : CityDataManager){
        self.city = city
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView(arrangedSubviews:[cityImage, nameLabel,countryLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)
        self.view.backgroundColor = UIColor.white
        
        let safeGuid = self.view.safeAreaLayoutGuide
        
        //only allow vertical scroll
        NSLayoutConstraint .activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeGuid.leadingAnchor , constant: layoutMargin),
            stackView.trailingAnchor.constraint(equalTo: safeGuid.trailingAnchor , constant: -layoutMargin),
            
            scrollView.topAnchor.constraint(equalTo: safeGuid.topAnchor, constant: layoutMargin),
            scrollView.bottomAnchor.constraint(equalTo: safeGuid.bottomAnchor,constant: layoutMargin),
            scrollView.leadingAnchor.constraint(equalTo: safeGuid.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeGuid.trailingAnchor),
            ])
        
        //set up View
        nameLabel.text = city.name
        countryLabel.text = city.contury
        detailLabel.text = city.description
        dataManager.getImageForCity(city) {[weak self] (result) in
            if case .success(let image) = result {
                self?.cityImage.image = image
            }
        }
    }
}
