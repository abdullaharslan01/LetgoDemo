
import Foundation

class MyAddsViewModel {
    
    private var myProductList: [Product]
 = []
    
    func getMyAdds(complation: @escaping(_ state:Int)->Void){
        
        WebServices.shared.getMyAdds { [self] productModel in
            if let productModel = productModel {
                
                myProductList = productModel.liste ?? []
                complation(1)
            }
            else {
                complation(0)
            }
        }
        
    }
    
    
    
    func productNumberOfItemsInSection() -> Int {
        return myProductList.count
    }




    func myProduct(at index:Int) -> Product? {
        
        guard index >= 0 && index < myProductList.count else {return nil}
        
        return myProductList[index]
    }

    
}




