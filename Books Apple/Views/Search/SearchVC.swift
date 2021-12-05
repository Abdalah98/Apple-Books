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
    var bookName = [ResultSearch]()
    
    var ViewModel : SearchViewModel = {
        return SearchViewModel()
    } ()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        tableViewDesign()
        configureNIBCell()
        configureSearch()
        //   initVM()
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
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.showLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        ViewModel.reloadTableViewClouser = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        ViewModel.initFetchData(searchText: searchText)
    }
}
extension SearchVC : UITableViewDataSource , UITableViewDelegate{
    
    
    func configureNIBCell(){
        let nib = UINib(nibName: Constant.SearchCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.SearchCell)
    }
    
    
    func tableViewDesign() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  ViewModel.numofCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.SearchCell) as! SearchCell
        let result = ViewModel.getCellViewModel(at: indexPath)
        cell.searchCellViewModel = result
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ViewModel.userPressed(at: indexPath)
        performSegue(withIdentifier: "show", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchDetailsVC,
           let photo = ViewModel.selectIndex {
            vc.imageResult  = photo.artworkUrl100
            vc.discrationResult   = photo.resultDescription
            vc.nameResult    = photo.artistName
            vc.titleNiv   = photo.trackCensoredName
        }
    }           
    
}
extension SearchVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initVM(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ViewModel.cellViewModel.removeAll()
        self.tableView.reloadData()
        self.dismissLoadingView()
        
    }
    
}
