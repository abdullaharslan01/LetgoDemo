//
//  AccountVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class AccountVC: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUser()

    }
    func setUpUser()
    {
        DispatchQueue.main.async{
            
    
            let user = UserPref().getUserInfo()
            
            if let user = user {
                self.userNameLabel.text = "\(user.id) \(user.adsoyad) \(user.resim)"
                
            }
            
            
            
        }
    }

   

}
