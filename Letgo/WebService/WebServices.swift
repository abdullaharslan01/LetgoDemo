//
//  WebServices.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import Foundation

class WebServices {
   static let shared = WebServices()
    private init() {}
    
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
