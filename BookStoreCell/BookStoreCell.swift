//
//  BookStoreCell.swift
//  Books Apple
//
//  Created by Abdallah on 11/27/21.
//

import UIKit

class BookStoreCell: UICollectionViewCell {
    @IBOutlet weak var imageBook: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var bookCellModel: BookStoreCellViewModel?{
        didSet{
            imageBook.sd_setImage(with: URL(string: bookCellModel?.image ?? ""))
            name.text = bookCellModel?.name
    }
    }
}
