//
//  BookStoreViewModel.swift
//  Books Apple
//
//  Created by Abdallah on 11/28/21.
//

import Foundation
import SDWebImage

class BookStoreViewModel  {
    let apiService : TopFreeBookServiceProtocol
    
    private  var books = [ResultBooks]()
    
    private var cellViewModel : [BookStoreCellViewModel] = [BookStoreCellViewModel](){
        didSet{
            self.reloadCollectionViewClouser?()
        }
    }
    
    
    
    var reloadCollectionViewClouser :(()->())?
    var showAlertClouser: (()->())?
    var updateLoadingStatus: (()->())?

    init(apiService : TopFreeBookServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    var numberOfCell :Int {
        return cellViewModel.count
    }
        var alertMessage: String? {
            didSet {
                self.showAlertClouser?()
            }
        }

    func initFetchData(){

        apiService.getTopFreeBook{[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.books = response.feed?.results ?? []


            case .failure(let error):
                self.alertMessage = error.rawValue

            }
        }
    }
    
    
    
    func getCellViewModel(at indexPath : IndexPath) -> BookStoreCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    func createCellViewModel( book: ResultBooks ) -> BookStoreCellViewModel {
        var descTextContainer: [String] = [String]()
        if let name = book.name{
            descTextContainer.append(name)
        }
        if let nameArtist = book.artistName{
            descTextContainer.append(nameArtist)
        }
        if let image = book.artworkUrl100{
            descTextContainer.append(image)
        }
        if let url = book.url{
            descTextContainer.append(url)
        }
        if let artistUrl = book.artistUrl{
            descTextContainer.append(artistUrl)
        }
        if let date = book.releaseDate{
            descTextContainer.append(date)
        }
        return BookStoreCellViewModel(image: book.artworkUrl100 ?? "", name: book.name ?? "", nameArtist: book.artistName ?? "", date: book.releaseDate ?? "", url: book.url ?? "", urlArtist: book.artistUrl ?? "")
    }
    private func processFetchedBook( books: [ResultBooks] ) {
        self.books = books // Cache
        var vms = [BookStoreCellViewModel]()
        for book in books {
            vms.append( createCellViewModel(book: book) )
        }
        self.cellViewModel = vms
    }}
