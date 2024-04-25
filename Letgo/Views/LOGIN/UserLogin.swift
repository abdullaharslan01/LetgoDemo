//
//  UserLogin.swift
//  Letgo
//
//  Created by abdullah on 25.04.2024.
//

import Foundation

struct UserResponse: Codable {
    let message: String
    let liste: [UserLogin]?
    let success: Int
    
}

struct UserLogin: Codable {
    
    let id: String
    let adsoyad: String
    let resim: String
}
