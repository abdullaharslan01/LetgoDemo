//
//  UserPref.swift
//  Letgo
//
//  Created by abdullah on 25.04.2024.
//

import Foundation



class UserPref{
    
    // Kullancının giriş yapıp yapmadığını kontrol ediyoruz.
    func loginStatus() -> Int{
        
        if let status = UserDefaults.standard.object(forKey: LoginStatus.loginStatus.rawValue) as? Int {
            print(status)
            return status
        }
        return 0
    }
    
    
    func loginStatusSet(status: LoginStatus) {
        UserDefaults.standard.setValue( status == .active ? 1 : 0, forKey: LoginStatus.loginStatus.rawValue)
    }
    
    
    func loginStatusLogOut() {
        UserDefaults.standard.removeObject(forKey: LoginStatus.loginStatus.rawValue)
    }
    
    
    func getUserInfo() -> UserLogin? {
        
        let user = UserDefaults.standard
        
        if let userid = user.object(forKey: UserKeys.userId.rawValue) as? String, let username = user.object(forKey: UserKeys.userNameSurname.rawValue) as? String, let userImage = user.object(forKey: UserKeys.userImage.rawValue) as? String{
            
            
            return UserLogin(id: userid, adsoyad: username, resim: userImage)
        }
        
        
        
        
        
        return nil
        
        
    }
    
    func setUserInfo(user: UserLogin ) {
        
        UserDefaults.standard.set(user.adsoyad, forKey: UserKeys.userNameSurname.rawValue)
        
        UserDefaults.standard.set(user.id, forKey: UserKeys.userId.rawValue)
        
        UserDefaults.standard.set(user.resim, forKey: UserKeys.userImage.rawValue)
        
    }
    
    
    
}







