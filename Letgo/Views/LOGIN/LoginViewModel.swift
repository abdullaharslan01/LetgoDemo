//
//  LoginViewModel.swift
//  Letgo
//
//  Created by abdullah on 25.04.2024.
//

import Foundation

class LoginViewModel {
    func login(email: String, password: String, completion: @escaping(UserResponse?)-> Void){
        
        let url = URL(string: "https://abdullaharslan.com.tr/letgo/uyegiris.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = "email=\(email)&sifre=\(password)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, errorr in
            if errorr != nil {
                print(errorr?.localizedDescription ?? "")
                completion(nil)
                return
            }
           
            if let data = data {
                do{
                    print(String(data: data, encoding: .utf8)!)
                    
                let decoder = JSONDecoder()
                    let userResponse = try decoder.decode(UserResponse.self, from: data)
                    
                    completion(userResponse)
            
                }catch{
                    print("Data Decode Fail: ",error.localizedDescription)
                    completion(nil)
                }
            }
            
            
        }.resume()
        
        
    }
}
