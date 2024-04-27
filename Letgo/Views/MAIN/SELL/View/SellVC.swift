//
//  SellVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class SellVC: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var sellImageView: UIImageView!
    @IBOutlet weak var sellTitle: UITextField!
    @IBOutlet weak var sellState: UISegmentedControl!
    @IBOutlet weak var sellDescription: UITextField!
    @IBOutlet weak var sellPrice: UITextField!
    // MARK: - Properties
    
    var productSellViewModel = ProductSellViewModel()
    
    // MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sellImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGalery)))
    }
    
    // MARK:  - Functions
    @objc func openGalery(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func sellButtonTapped(_ sender: Any) {
        
        productSellViewModel.uploadAdd(product: ProductSellModel(imageName: "", title: sellTitle.text ?? "", description: sellDescription.text ?? "", price: sellPrice.text ?? "")) { state in
            
            if state {
                
                DispatchQueue.main.async {
                    
                    NotificationCenter.default.post(name: .refleshScreen, object: nil)
                    
                    
                    
                    self.showAlert(title: "Success", message: "Your ad has been uploaded successfully", buttonTitle: "OK")
                    self.sellTitle.text = ""
                    self.sellPrice.text = ""
                    self.sellDescription.text = ""
                    self.sellImageView.image = UIImage(systemName: "photo")
                }
            }
            else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Fail", message: "Your ad could not be loaded, please try again", buttonTitle: "OK")
                }
            }
        }
      
    }

    

}
    extension SellVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedImage = info[.originalImage] as? UIImage {
                sellImageView.image = selectedImage
                
                self.dismiss(animated: true)
            }
        }
    }

