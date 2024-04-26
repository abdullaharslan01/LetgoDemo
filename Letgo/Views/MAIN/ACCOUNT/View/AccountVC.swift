//
//  AccountVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class AccountVC: UIViewController {

    // MARK: - UI Elements
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    // MARK: - Properties
    
    var accountViewModel = AccountViewModel()
    
    // MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate  = self
        categoryTableView.dataSource = self
        categoryTableView.rowHeight = CGFloat(accountViewModel.rowHeigh())
        categoryTableView.register(MenusCell.nib(), forCellReuseIdentifier: MenusCell.identifier)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    // MARK:  - Functions
    
    
    
    // MARK: - Actions
    
    // I am adding here exit button properties. I can add future this propreties
    @IBAction func viewAndEditProfileTapped(_ sender: UIButton) {
        
        self.showAlert(title: "Exit", message: "Your sessioun is closed", buttonTitle: "OK") {
       
           UserPref().loginStatusSet(status: .passive)
            
            let board = UIStoryboard(name: "Main", bundle: nil)
            
            if let destinationPage = board.instantiateViewController(withIdentifier: StoryBoarRoutes.TabbarLoginMainPage.rawValue) as? TabbarVC {
                
                destinationPage.modalPresentationStyle = .fullScreen
                destinationPage.modalTransitionStyle = .coverVertical
                
                self.present(destinationPage, animated: true)
                
                
            }
            
        }
        
       
    }
    

   

}

extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.menuNumberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenusCell.identifier) as! MenusCell
        
        cell.configure(with: accountViewModel.menuItemWithIndex(at: indexPath.row)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
}
