//
//  CategoryCollectionViewCell.swift
//  Letgo
//
//  Created by abdullah on 25.04.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "CategoryCollectionViewCell"
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with category:CategoryModel) {
        
        categoryImageView.image = UIImage(named: category.imageName)
        categoryName.text = category.categoryName
    }

}

