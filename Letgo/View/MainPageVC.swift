//
//  MainPageVC.swift
//  Letgo
//
//  Created by abdullah on 22.04.2024.
//

import UIKit

class MainPageVC: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
  
    
    // MARK: - Properties
    
    
    
    // MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .gray
        
        

        
    }
    
    // MARK:  - Functions
    
    @IBAction func continueWithPlatforms(_ button: UIButton){
        
        let ac = UIAlertController(title: "Sorry", message: "Currently you can only log in via email. It will be added as soon as possible. Thanks.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
        
    }
    
    
    @IBAction func continueWithEmail(_ sender: Any) {
     
        performSegue(withIdentifier: SegueNames.registerVC.rawValue, sender: nil)
        
    }
    
    
    
    // MARK: - Actions
    

   

}
