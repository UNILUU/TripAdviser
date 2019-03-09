//
//  MainTableViewController.swift
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var dataManager : CityDataManager
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataManager = CityDataManager.shared
        super.init(nibName: nil, bundle: nil)
        dataManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier())
    }
    
    //MARK : - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = dataManager.getCity(at: indexPath.row){
            self.navigationController?.pushViewController(CityDetailViewController(city, dataManager), animated: true)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getCityCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier(), for: indexPath)
        assert(c is TableViewCell, "cell not valid")
        let cell = c as! TableViewCell
        if let city = dataManager.getCity(at: indexPath.row){
            cell.setUpCell(city)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         guard let city = dataManager.getCity(at: indexPath.row) else {
            return
        }
        if let tableCell = cell as? TableViewCell{
            dataManager.getImageForCity(city) {(result) in
                if case .success(let image) = result {
                   tableCell.cityImage.image = image
                }
            }
        }
    }
}


extension MainTableViewController : CityDataManagerDelegate{
    func dataDidChange() {
        self.tableView.reloadData()
    }
}
