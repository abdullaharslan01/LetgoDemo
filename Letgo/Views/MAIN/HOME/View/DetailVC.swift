//
//  DetailVC.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import UIKit
import SDWebImage


class DetailVC: UIViewController {

    // MARK: - UI Elements
        
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    // MARK: - Life Cycle
    
    @IBOutlet weak var userLabel: UILabel!
    
    var productUser: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    // MARK:  - Functions
    
    
    
    func configure(){
        
        var image = productUser?.resim ?? "https://abdullaharslan.com.tr/letgo/images/products/placeholder.jpg"
        
        detailImage.sd_setImage(with: URL(string: image)!)
        
        titleLabel.text = productUser?.baslik ?? ""
        contentLabel.text = productUser?.icerik ?? ""
    
        priceLabel.text = "\(productUser?.fiyat ?? "0") TL"
        userLabel.text  = "User \(productUser?.kullaniciid ?? "Unknown")"
    }
    
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

