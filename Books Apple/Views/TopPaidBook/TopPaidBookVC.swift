//
//  TopPaidBookVC.swift
//  Books Apple
//
//  Created by Abdallah on 12/4/21.
//

import UIKit

class TopPaidBookVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel: TopPaidBookViewModel = {
      return  TopPaidBookViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Paid Book"

        configureCollection()
    //    initVM()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()

    }

    func initVM(){
        viewModel.showAlertClouser = {[weak self] in ()
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage  {
                    self?.showAlert(message)
                }
            }
            
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.collectionView.alpha = 0.0
                    })
                case .loading:
                    self.showLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.collectionView.alpha = 0.0
                    })
                case .populated:
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.collectionView.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadcollectionViewClouser = {[weak self] in ()
            DispatchQueue.main.async {

                self?.collectionView.reloadData()
            }
        }
        viewModel.initFetchData()
    }

}
extension TopPaidBookVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    fileprivate func configureCollection(){
        let nib = UINib(nibName: Constant.BookStoreCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constant.BookStoreCell)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //    return books.count
        return viewModel.numberOfCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.BookStoreCell , for: indexPath) as? BookStoreCell
        else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.bookCellModel = cellVM
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // the width oh this var is the math calculate the screen now i needed 2 coulme in row ok  there is two coulme 16|coulme|16|coulme|16 the culculate of 3 * 16 ok
        let width = (view.frame.width - 3 * 16) / 2
        return CGSize(width: width, height: width + 60 )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16 , bottom: 5, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        self.viewModel.userPressed(at: indexPath)
        performSegue(withIdentifier: "show", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsVS,
           let book = viewModel.selectIndexBooks {
            vc.copyRight = book.artistName
            vc.Relase = book.releaseDate
            vc.image = book.artworkUrl100
            vc.name = book.name
            vc.nameArtist = book.artistName
            vc.url = book.url
            vc.artistUrl = book.artistUrl

        }
    }
}
