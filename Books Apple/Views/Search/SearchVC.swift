//
//  SearchVC.swift
//  Books Apple
//
//  Created by Abdallah on 12/1/21.
//

import UIKit
import SDWebImage

class SearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    var ViewModel : SearchViewModel = {
        return SearchViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        tableViewDesign()
        configureNIBCell()
        configureSearch()
    }
    
    fileprivate func configureSearch() {
        searchController.searchBar.placeholder = "Search Here"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    func initVM(searchText:String){
        
        ViewModel.showAlertClouser = { [weak self ] () in
            DispatchQueue.main.async {
                if let message = self?.ViewModel.alertMessage {
                    self?.showAlert( message )
                }                    }
            
        }
        ViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.ViewModel.state {
                case .empty, .error:
                    self.dismissLoadingView()
                 
                case .loading:
                    self.showLoadingView()
                   
                case .populated:
                    self.dismissLoadingView()
                }
            }
        }
        
        ViewModel.reloadTableViewClouser = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        ViewModel.initFetchData(searchText: searchText)
    }
}


extension SearchVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initVM(searchText: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ViewModel.cellViewModel.removeAll()
        self.tableView.reloadData()
        
    }
    
}
