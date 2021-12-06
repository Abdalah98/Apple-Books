//
//  SearchCell.swift
//  Books Apple
//
//  Created by Abdallah on 11/27/21.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var imageViewBook: UIImageView!
    @IBOutlet weak var nameBook: UILabel!
    @IBOutlet weak var nameArtist: UILabel!
    

    var searchCellViewModel:SearchCellViewModel?{
        didSet{
            nameBook.text =    searchCellViewModel?.nameBook  ?? ""
            nameArtist.text = searchCellViewModel?.nameArtist  ?? ""
            imageView?.sd_setImage(with: URL(string: searchCellViewModel?.imageViewBook  ?? ""))
        }
        
    }
}
