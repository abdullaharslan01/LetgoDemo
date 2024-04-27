//
//  WebServices.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import Foundation
import UIKit

class WebServices {
    static let shared = WebServices()
    private init() {}
    

    func getMyAdds(complation: @escaping(ProductModelList?)->Void){
        let kullaniciid = UserPref().getUserInfo()?.id

        let url =  URL(string: "https://abdullaharslan.com.tr/letgo/listeilanlarim.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postData = "kullaniciid=\(kullaniciid ?? "0")"
        request.httpBody = postData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, errorr in
            
            if errorr != nil {
                print(errorr?.localizedDescription ?? "")
                complation(nil)
            }
            else {
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        
                        let dataResponse = try decoder.decode(ProductModelList.self, from: data)
                        complation(dataResponse)
                        
                        
                    } catch {
                        complation(nil)
                    }
                    
                }
            }
            
        }.resume()
        
    }
    
    
    
    func uploadAdd(product: ProductSellModel, complation: @escaping(Bool) -> Void) {
        
        let placeHolder = "https://abdullaharslan.com.tr/letgo/images/products/placeholder.jpg"
        
        let kullaniciid = UserPref().getUserInfo()?.id
        let url = URL(string: "https://abdullaharslan.com.tr/letgo/ekle.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postData = "baslik=\(product.title)&resim=\(placeHolder)&icerik=\(product.description)&fiyat=\(product.price)&kullaniciid=\(kullaniciid ?? "51")"
        
        request.httpBody = postData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, errorr in
            if errorr != nil {
                complation(false)
            }
            else {
                
                do{
                    
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    
                    if let response =  result["message"] as? Int {
                        complation(response == 1 ? true: false)
                        return
                    }
                    
                    complation(false)
                    
                    
                    
                }catch{
                    complation(false)
                }
            }
            
        }.resume()
        
        
        
        
        
    }
    
    func getProductList(searchText: String, complation: @escaping(ProductModelList?)->Void)
    {
        let url =  URL(string: "https://abdullaharslan.com.tr/letgo/liste.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, errorr in
            
            if errorr != nil {
                print(errorr?.localizedDescription ?? "")
                complation(nil)
            }
            else {
                
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        
                        var dataResponse = try decoder.decode(ProductModelList.self, from: data)
                        
                        if !searchText.isEmpty {
                            
                            dataResponse.liste = dataResponse.liste?.filter{$0.baslik!.lowercased().contains(searchText.lowercased())}
                            
                        }
                        
                        
                        
                        
                        complation(dataResponse)
                        
                    } catch {
                        print("Decoder fail: ",error.localizedDescription)
                        complation(nil)
                    }
                    
                }
            }
            
        }.resume()
        
        
        
        
    }

}
