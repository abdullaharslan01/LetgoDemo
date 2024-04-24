//
//  RegisterViewModel.swift
//  Letgo
//
//  Created by abdullah on 23.04.2024.
//

import Foundation

class RegisterViewModel {
    func register(user: User, completion: @escaping(Bool,String)->Void) {
      
        
        if let name = user.name, let email = user.email, let password = user.password {
            
            let url = URL(string: "https://abdullaharslan.com.tr/letgo/register.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let postData = "adsoyad=\(name)&email=\(email)&sifre=\(password)"
        
            request.httpBody = postData.data(using: .utf8)
            URLSession.shared.dataTask(with: request) { data, response, errorr in
                if errorr != nil {
                    print(errorr?.localizedDescription ?? "")
                }
                else {
                    do {

                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                            
                            print(json)
                            let success = json["success"] as? Int ?? 0
                            let message = json["message"] as? String ?? ""
                            
                            completion(success == 1,message)
                            
                        }
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
            
            
        }
        
       
        
        
    }
}


