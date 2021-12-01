//
//  SearchVC.swift
//  Books Apple
//
//  Created by Abdallah on 12/1/21.
//

import UIKit
import SDWebImage
class SearchVC: UIViewController {
//SearchCell
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    var bookName = [ResultSearch]()
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
        return bookName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.SearchCell) as! SearchCell
        let data = bookName[indexPath.row]
       // cell.set(result: data)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: Constant.goDetailsMusicVideo, sender: self)
//
//    }
//
//    //MARK: - prepareSegue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constant.goDetailsMusicVideo {
//            let detailsController = segue.destination as! SearchDetails
//            if let indexPath = tableView.indexPathForSelectedRow {
//                detailsController.musicDetails = msuicName[indexPath.row]
//            }else{
//                return print("error")
//            }
//        }
//    }
}
extension SearchVC :UISearchBarDelegate, UISearchControllerDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoadingView()
        NetworkManger.shared.searchBooks(searchText: searchText) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.bookName = response.results ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.dismissLoadingView()

            case .failure(let error):
                self.dismissLoadingView()
                
                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        bookName.removeAll()
        self.tableView.reloadData()
        self.dismissLoadingView()

    }
    
}
