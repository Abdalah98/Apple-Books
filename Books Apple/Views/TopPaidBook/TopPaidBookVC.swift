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

