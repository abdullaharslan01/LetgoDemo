//
//  DetailVC.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import UIKit

class DetailVC: UIViewController {

    // MARK: - UI Elements
        
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var relatedAdds: UICollectionView!
    
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
        
        titleLabel.text = productUser?.baslik ?? ""
        contentLabel.text = productUser?.icerik ?? ""
        detailImage.image = UIImage(named: "teknoloji")
        priceLabel.text = "\(productUser?.fiyat ?? "0") TL"
        userLabel.text  = "User \(productUser?.kullaniciid ?? "Unknown")"
    }
    
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedCell", for: indexPath)
        
        return cell
        
    }
    
    
}
