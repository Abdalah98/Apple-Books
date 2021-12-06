//
//  SearchTableView+EXT.swift
//  Books Apple
//
//  Created by Abdallah on 12/6/21.
//

import UIKit
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
        print(ViewModel.numofCell)
        return  ViewModel.numofCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: Constant.SearchCell) as? SearchCell else {
            fatalError("Cell not exists in storyboard")
        }
        let result = ViewModel.getCellViewModel(at: indexPath)
        cell.searchCellViewModel = result
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ViewModel.userPressed(at: indexPath)
        performSegue(withIdentifier: Constant.SearchDetails, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc           = segue.destination as? SearchDetailsVC,
           let photo        = ViewModel.selectIndex {
            vc.imageResult  = photo.artworkUrl100
            vc.discrationResult   = photo.resultDescription
            vc.nameResult         = photo.artistName
            vc.titleNiv          = photo.trackCensoredName
        }
    }
    
}
