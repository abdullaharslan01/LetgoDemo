//
//  Enums.swift
//  Letgo
//
//  Created by abdullah on 22.04.2024.
//

import Foundation

enum SegueRoutes: String {
    case registerVC
    case loginVC
    case tabbarVC
    case detailVC
}

enum StoryBoarRoutes: String
{
    case HomePage
    case LoginMainPage
   case TabbarLoginMainPage
        
}



enum UserKeys: String {
    case userId
    case userNameSurname
    case userImage
}


enum LoginStatus: String {
    case loginStatus
    case active
    case passive
}


