//
//  DetailsVS.swift
//  Books Apple
//
//  Created by Abdallah on 11/27/21.
//

import UIKit

class DetailsVS: UIViewController {
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var image : String?
    var copyRight : String?
    var name : String?
    var nameArtist : String?
    var Relase : String?
    var url : String?
    var artistUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "©\(copyRight ?? "")"
        releaseDateLabel.text = Relase
        nameLabel.text = name
        artistNameLabel.text = nameArtist
        imageBook.sd_setImage(with: URL(string: image ?? "" ))
    }
    
    
    @IBAction func urlAction(_ sender: Any) {
        goSafari(urlString: url ?? "")
    }
    
    @IBAction func artistUrlAction(_ sender: Any) {
        goSafari(urlString: artistUrl ?? "")
        
    }
    
}


