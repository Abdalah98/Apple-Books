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
    
    lazy var bookStoreViewModel: TopFreeBookViewModel =
        {
            return   TopFreeBookViewModel()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Free Book"
        configureCollection()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()
        
    }
    
    func initVM(){
        bookStoreViewModel.showAlertClosure = { [weak self ] () in
            DispatchQueue.main.async {
                if let message = self?.bookStoreViewModel.alertMessage {
                    self?.showAlert( message )
                }                    }
            
        }
        bookStoreViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.bookStoreViewModel.state {
                case .empty, .error:
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.bookStoreCollectionView.alpha = 0.0
                    })
                case .loading:
                    self.showLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.bookStoreCollectionView.alpha = 0.0
                    })
                case .populated:
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.bookStoreCollectionView.alpha = 1.0
                    })
                }
            }
        }
        
        bookStoreViewModel.reloadCollectionViewClouser = {
            DispatchQueue.main.async {
                self.bookStoreCollectionView.reloadData()
            }
            
        }
        bookStoreViewModel.initFetchData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




