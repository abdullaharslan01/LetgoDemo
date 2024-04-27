//
//  CategoryViewModel.swift
//  Letgo
//
//  Created by abdullah on 25.04.2024.
//

import Foundation

class HomeViewModel {
    
    private var categoryList: [CategoryModel] = [
        CategoryModel(imageName: "otoplus", categoryName: "OTOPLUS"),
        CategoryModel(imageName: "araba", categoryName: "ARABA"),
        CategoryModel(imageName: "telefon", categoryName: "TELEFON"),
        CategoryModel(imageName: "ev", categoryName: "EV EŞYALARI"),
        CategoryModel(imageName: "elektronik", categoryName: "ELEKTRONİK"),
        CategoryModel(imageName: "motosiklet", categoryName: "MOTOSİKLET"),
        CategoryModel(imageName: "diger", categoryName: "DİĞER ARAÇLAR"),
        CategoryModel(imageName: "bebek", categoryName: "BEBEK VE ÇOCUK"),
        CategoryModel(imageName: "spor", categoryName: "SPOR VE OUTDOOR"),
        CategoryModel(imageName: "hobi", categoryName: "HOBBİ VE EĞLENCE"),
        CategoryModel(imageName: "giyim", categoryName: "GİYİM VE AKSESUAR")
    ]
    
     var productList: [Product] = []
    
    func getProductList(searchText: String = "", complation: @escaping(_ state:Int)->Void)
    {
    
        WebServices.shared.getProductList(searchText: searchText) { [self] productModelList in
            
            if productModelList == nil {
                complation(0)
            }
            else{
                productList = productModelList?.liste ?? []

                complation(1)
            }
        }
        
        
        
    }
    
    
    
    func categoryNumberOfItemsInSection() -> Int {
        return categoryList.count
    }
    
    func productListyNumberOfItemsInSection() -> Int {
        return productList.count 
    }
    
    
    func categoryId(at index:Int) -> CategoryModel? {
        
        guard index >= 0 && index < categoryList.count else {return nil}
        
        return categoryList[index]
    }
    
    func productId(at index:Int) -> Product? {
        
        guard index >= 0 && index < productList.count else {return nil}
        
        return productList[index]
        
    }
    

    
    
}



