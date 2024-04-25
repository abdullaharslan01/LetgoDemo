//
//  AlertController.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String, completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    
}
