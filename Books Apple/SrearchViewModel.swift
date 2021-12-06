//
//  SrearchViewModel.swift
//  Books Apple
//
//  Created by Abdallah on 12/5/21.
//

import Foundation
class SearchViewModel {
    
    let apiService : SearchBookServiceProtocol
    private var  resultBook = [ResultSearch]()
    var selectIndex : ResultSearch?
    
    init( apiService : SearchBookServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    var reloadTableViewClouser:(()->())?
    var showAlertClouser:(()->())?
    var updateLoadingStatus : (()->())?
    
    
    var cellViewModel:[SearchCellViewModel] = [SearchCellViewModel](){
        didSet{
            self.reloadTableViewClouser?()
        }
    }
    
    var state:State = .empty {
        didSet{
            showAlertClouser?()
        }
    }
    
    var alertMessage : String?{
        didSet{
            updateLoadingStatus?()
        }
    }
    
    var numofCell : Int {
        return cellViewModel.count
    }
    
    func getCellViewModel(at indexPath : IndexPath) -> SearchCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func creatCellModel(resultBook : ResultSearch)->SearchCellViewModel{
        let image = resultBook.artworkUrl100
        let name = resultBook.trackName
        let artistName = resultBook.artistName
        return SearchCellViewModel(imageViewBook: image ?? "", nameBook: name ?? "", nameArtist: artistName ?? "")
    }
    
    func processFetchedBook(result : [ResultSearch]){
        // api
        self.resultBook = result
        
        var vms = [SearchCellViewModel]()
        // save in cell model
        for result in result {
            vms.append(creatCellModel(resultBook: result))
        }
        // equel cell view model
        self.cellViewModel = vms
    }
    func userPressed(at indexPath : IndexPath){
        let book = resultBook[indexPath.item]
        self.selectIndex = book
    }
    
    
    func initFetchData(searchText : String){
        apiService.searchResultBook(searchText: searchText) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.processFetchedBook(result: response.results ?? [])
                self.state = .populated
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
                
            }
        }
    }
}
