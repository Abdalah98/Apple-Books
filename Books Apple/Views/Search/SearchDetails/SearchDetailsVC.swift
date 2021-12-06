//
//  SearchDetailsVC.swift
//  Books Apple
//
//  Created by Abdallah on 12/5/21.
//

import UIKit

class SearchDetailsVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dis: UILabel!
    
    var nameResult : String?
    var discrationResult : String?
    var imageResult :String?
    var titleNiv : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleNiv
        name.text = nameResult
        dis.text  = discrationResult
        image.sd_setImage(with:URL(string:imageResult ?? "" ))
    }
    

   

}
