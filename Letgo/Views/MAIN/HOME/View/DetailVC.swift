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
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var favoriButton: UIBarButtonItem!
    @IBOutlet weak var makeOfferbutton: UIButton!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    // MARK: - Life Cycle
    
    @IBOutlet weak var userLabel: UILabel!
    
    var productUser: Product?
    
    var isMyAdds: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editScreenIfMyAdds()
        configure()
        
    }
    
    // MARK:  - Functions
    
    func editScreenIfMyAdds(){
        
        if let configureState = isMyAdds{
            
            if configureState {
                
                favoriButton.isHidden = true
            
                makeOfferbutton.isHidden = true
                chatButton.setTitle("EDIT", for: .normal)
                
                chatButton.setImage(UIImage(systemName: ""), for: .normal)
                
                NSLayoutConstraint.activate([
                    chatButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20),
                    chatButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20),
                    chatButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 20),
                    chatButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -20)
                ])
                
                
            }
            else {
                
            }
            
            
            
        }
        
    }
    
    
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        var itemInfo = "I'm selling this product, it may be useful for you: \(productUser?.baslik ?? "")"
        
        if let image = detailImage.image?.jpegData(compressionQuality: 0.8)  {
            
            let shareActivetyController = UIActivityViewController(activityItems: [itemInfo,image], applicationActivities: [])

            present(shareActivetyController, animated: true)
            
        }

        
        
        
        
    }
    
    
    
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

