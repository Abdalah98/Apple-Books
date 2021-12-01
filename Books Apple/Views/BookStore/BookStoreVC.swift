//
//  BookStoreVC.swift
//  Books Apple
//
//  Created by Abdallah on 11/27/21.
//

import UIKit
import SDWebImage
class BookStoreVC: UIViewController {

    @IBOutlet weak var bookStoreCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        // Do any additional setup after loading the view.
    }
    var books = [ResultBooks]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NetworkManger.shared.getTopFreeBook{[weak self] result in
            guard let self = self else{return}
            self.dismissLoadingView()
            switch result {
            case .success(let response):
                
                self.books = response.feed?.results ?? []
                    DispatchQueue.main.async {
                        self.title = response.feed?.title
                    self.bookStoreCollectionView.reloadData()
                }
                self.dismissLoadingView()

            case .failure(let error):
                self.dismissLoadingView()
                
                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
        
    }
    
}


  

extension BookStoreVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
 

    fileprivate func configureCollection(){
        let nib = UINib(nibName: Constant.BookStoreCell, bundle: nil)
        bookStoreCollectionView.register(nib, forCellWithReuseIdentifier: Constant.BookStoreCell)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.BookStoreCell , for: indexPath) as! BookStoreCell
        let databooks = books[indexPath.row]
        cell.name.text = databooks.artistName
        cell.imageBook.sd_setImage(with:URL(string: databooks.artworkUrl100 ?? ""))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // the width oh this var is the math calculate the screen now i needed 2 coulme in row ok  there is two coulme 16|coulme|16|coulme|16 the culculate of 3 * 16 ok
        let width = (view.frame.width - 3 * 16) / 2
        return CGSize(width: width, height: width + 60 )
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16 , bottom: 5, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
