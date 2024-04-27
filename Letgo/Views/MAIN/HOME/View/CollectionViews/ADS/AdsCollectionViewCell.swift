//
//  AdsCollectionViewCell.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import UIKit

import SDWebImage

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
   
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productLocation: UILabel!

    
    
    static let identifier = "AdsCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AdsCollectionViewCell", bundle: nil)
    }
    
    
    
    func configure(with product: Product?) {
        
        if let product = product {
            productImage.sd_setImage(with: URL(string: product.resim!))
            
            productPrice.text = "\(product.fiyat?.description ?? "0") TL"
            productTitle.text = product.baslik
            
            // I haven't add location in the database for adds Because I have created this app for demo. But other information will come from Database in my API
            productLocation.text = "Yüreğir"
        }
        
        
      
        
        
    }
    
    
}
