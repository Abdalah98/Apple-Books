//
//  BookStoreViewModel.swift
//  Books Apple
//
//  Created by Abdallah on 11/28/21.
//

import Foundation

class TopFreeBookViewModel  {
    let apiService : ApiServiceProtocol
    var selectedPhoto: ResultBooks?

    private  var book = [ResultBooks]()
    
    private var cellViewModel : [BookStoreCellViewModel] = [BookStoreCellViewModel](){
        didSet{
            self.reloadCollectionViewClouser?()
        }
    }
    
    
    
    var reloadCollectionViewClouser :(()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init(apiService : ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    //    // callback for interfaces

    var numberOfCell :Int {
        return cellViewModel.count
    }
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
     
    
    func initFetchData(){
        state = .loading
//
        apiService.getTopFreeBook(){[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.processFetchedBook(books: response.feed?.results ?? [])
                self.state = .populated
            
            case .failure(let error): 
                self.state = .error
                self.alertMessage = error.rawValue

            }
        }
    }
    
    
    
    func getCellViewModel(at indexPath : IndexPath) -> BookStoreCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    func createCellViewModel( book: ResultBooks ) -> BookStoreCellViewModel {
        let name = book.name
         let nameArtist = book.artistName
         let image = book.artworkUrl100

        return BookStoreCellViewModel(image:image ?? "", name: name ?? "", nameArtist: nameArtist ?? "")
    }
    
    private func processFetchedBook( books: [ResultBooks] ) {
        self.book = books // Cache
        var vms = [BookStoreCellViewModel]()
        for book in books {
            print(books.count)
            vms.append( createCellViewModel(book: book) )
            
        }
        self.cellViewModel = vms
    }
    
    
    func userPressed( at indexPath: IndexPath ){
        let book = self.book[indexPath.row]
    
            self.selectedPhoto = book
      
        
    }

}
