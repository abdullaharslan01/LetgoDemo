import Foundation
import UIKit

class ProductSellViewModel {
    

    
    func uploadAdd(product: ProductSellModel, complation: @escaping(Bool)->Void) {
        WebServices.shared.uploadAdd(product: product) { state in
         
            complation(state)
            
        }
    }
    
    
    
    
}

