//
//  HomeViewController.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //TableView
    @IBOutlet weak var homeTableView: UITableView!
    
    //ViewModel
    let viewModel = HomeViewModel()
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cell Registration
        registerTableViewCells()
        
        //Make API Call to fetch Data
        fetchData()
        
        //Set Navigation Bar Title
        setNavBarTitle()
        
    }

    //---Nav Bar Title Setup
    func setNavBarTitle() {
        navigationItem.title = "Movies"
    }
    
    //Register Table View Cell
    func registerTableViewCells() {
        homeTableView.register(UINib(nibName: CellIdentifier.HomeTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.HomeTableViewCell.rawValue)
        homeTableView.register(UINib(nibName: CellIdentifier.HomeTableLoaderCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.HomeTableLoaderCell.rawValue)
    }
    
    //MARK: Fetch Initial Data
    func fetchData() {
        
        if viewModel.items.count > 0, viewModel.items.count == viewModel.totalResults {
            return
        }
        
        if ReachabilityHelper.shared.isNetworkAvailable {
            
            //Show Page Level loader only if you dont have any data
            if viewModel.items.count == 0 {
                self.showActivityIndicator()
            }
            
            //Fetch Page Data
            viewModel.fetchPageData(pageId: viewModel.currentPage + 1) { [weak self](resp, error, responseCode) in
                self?.hideActivityIndicator()
                if let dataModel = resp, let strongSelf = self {
                    if strongSelf.viewModel.items.count > 0 {
                        strongSelf.updateWithLocalData(dataModel: dataModel)
                    } else {
                        strongSelf.updateWithoutLocalData(dataModel: dataModel)
                    }
                } else {
                    //Remove Loader if existing
                    self?.removeLoader()
                }
            }
        }
    }
    
    //---Update Data if data is retrieved first time
    func updateWithoutLocalData(dataModel: HomeDataModel) {
        viewModel.setupData(data: dataModel)
        setLoaderData()
        homeTableView.reloadData()
    }
    
    //---Update Data in case of data present from before
    func updateWithLocalData(dataModel: HomeDataModel) {
        homeTableView.beginUpdates()
        removeLoader()
        let start = viewModel.items.count
        viewModel.setupData(data: dataModel)
        setLoaderData()
        let end = viewModel.items.count - 1
        self.homeTableView.insertRows(at: fetchIndexPath(start: start, end: end), with: .none)
        homeTableView.endUpdates()
    }
    
    //---Fetch IndexPath
    func fetchIndexPath(start: Int, end: Int) -> [IndexPath] {
        var items = [IndexPath]()
        for i in start...end{
            items.append(IndexPath.init(row: i, section: 0))
        }
        return items
    }
    
    func setLoaderData() {
        //Append Loader if not completed
        if viewModel.items.count != viewModel.totalResults, viewModel.items.filter({$0.cellType == .Loader}).count == 0 {
            let model = HomeCellViewModel()
            model.cellType = .Loader
            viewModel.items.append(model)
        } else if viewModel.items.count == viewModel.totalResults {
            removeLoader()
        }
    }
    
    //---Hide Loader
    func removeLoader() {
        if let item = viewModel.items.filter({$0.cellType == .Loader}).first, let index = viewModel.items.firstIndex(of: item) {
            viewModel.items.remove(at: index)
            
            //Update UI
            self.homeTableView.beginUpdates()
            self.homeTableView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
            self.homeTableView.endUpdates()
        }
    }

}

//MARK: Table View Delegate
extension HomeViewController: UITableViewDelegate {
    
    //---Set Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = viewModel.items[indexPath.row]
        switch model.cellType {
        case .Data:
            return 200
        case .Loader:
            return 100
        }
    }
    
}

//MARK: Table View Data Source
extension HomeViewController: UITableViewDataSource {
    
    //Items in the list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    //Cell for UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.items[indexPath.row]
        
        //Make API call to fetch data on last cell
        if viewModel.items.count - 1 == indexPath.row {
            fetchData()
        }
        
        switch model.cellType {
        case .Data:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.HomeTableViewCell.rawValue) as! HomeTableViewCell
            let model = viewModel.items[indexPath.row]
            cell.setupData(model: model)
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        case .Loader:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.HomeTableLoaderCell.rawValue) as! HomeTableLoaderCell
            cell.startAnimating()
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    
}
