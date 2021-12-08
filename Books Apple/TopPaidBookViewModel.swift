//
//  TopPaidBookViewModel.swift
//  Books Apple
//
//  Created by Abdallah on 12/4/21.
//

import Foundation
class TopPaidBookViewModel {
    
    private var books = [ResultBooks]()
    
    var selectIndexBooks : ResultBooks?
    let apiService : TopPaidBookServiceProrocol
    
    init(apiService : TopPaidBookServiceProrocol = ApiService()) {
        self.apiService = apiService
    }
    
    var reloadcollectionViewClouser:(()->())?
    var showAlertClouser:(()->())?
    var updateLoadingStatus : (()->())?
    
    private var cellViewModel: [BookStoreCellViewModel] = [BookStoreCellViewModel](){
        didSet{
            self.reloadcollectionViewClouser?()
        }
    }
    
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClouser?()
        }
    }
    var numberOfCell : Int{
        return cellViewModel.count
    }
    
    func initFetchData(){
        state = .loading

        apiService.getTopPaidBooks(urlString: URLS.topPaidBooks) { [weak self] result in
                guard let self = self else{return}
                switch result {
                case .success(let response):
                    
                   // self.book = response.feed?.results ?? []
                    self.processFetchedBook(books: response.feed?.results ?? [])
                    self.state = .populated
                
                case .failure(let error):
                    self.state = .error
                    self.alertMessage = error.rawValue

                }
            }
        }
    
    func getCellViewModel(at indexPath : IndexPath)-> BookStoreCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    func creatCellModel(book: ResultBooks)->BookStoreCellViewModel{
        let image = book.artworkUrl100
        let name = book.name
        let artistName = book.artistName
        return BookStoreCellViewModel(image: image ?? "", name: name ?? "", nameArtist: artistName ?? "")
    }
   
    private func processFetchedBook (books:[ResultBooks]){
        self.books = books
        var vms = [BookStoreCellViewModel]()
        for book in books {
            vms.append(creatCellModel(book: book))
            
        }
        self.cellViewModel = vms
    }
    
    func userPressed(at indexPath : IndexPath){
        let book = books[indexPath.item]
        self.selectIndexBooks = book
    }
    
    
  
    }

