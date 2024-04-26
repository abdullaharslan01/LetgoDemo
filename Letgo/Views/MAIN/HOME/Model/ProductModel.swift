//
//  ProductModel.swift
//  Letgo
//
//  Created by abdullah on 26.04.2024.
//

import Foundation

struct ProductModelList: Decodable {
    var success: Int?
    var liste: [Product]?
}

struct Product: Decodable{
    var id: String?
    var baslik: String?
    var resim: String?
    var icerik: String?
    var fiyat: String?
    var kullaniciid: String?
}
