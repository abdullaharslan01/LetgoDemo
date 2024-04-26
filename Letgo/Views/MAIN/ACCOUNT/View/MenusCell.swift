//
//  MenusCell.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import UIKit

class MenusCell: UITableViewCell {

    @IBOutlet var leadingIconImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    

    static let identifier = "MenusCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    func configure(with accountMenuModel: AccountMenuModel) {
        
      
            leadingIconImageView.image = UIImage(systemName: accountMenuModel.leadingIcon!)
        
        title.text = accountMenuModel.title
        subtitle.text = accountMenuModel.subtitle
            
        
        
      
    }
    
    
    
}
