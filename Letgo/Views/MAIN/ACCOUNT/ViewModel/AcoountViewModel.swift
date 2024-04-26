import Foundation


class AccountViewModel {
    
    private var menus: [AccountMenuModel] = [
        
        AccountMenuModel(title: "My Network", subtitle: "Followers, following and find friends", leadingIcon: "person.2.fill"),
        
        AccountMenuModel(title: "My Orders & Biling", subtitle: "Orders, invoices & biling information", leadingIcon: "creditcard.fill"),
        
        AccountMenuModel(title: "Settings", subtitle: "Privacy and logout", leadingIcon: "gear"),
        
        AccountMenuModel(title: "Help and Support", subtitle: "Help center, Terms and conditions, Privacy policy", leadingIcon: "info.circle.fill")
    
    ]
    
    
    func menuNumberOfItemsInSection() -> Int {
        return menus.count
    }
    
    
    
    func menuItemWithIndex(at index:Int) -> AccountMenuModel? {
        
        guard index >= 0 && index < menus.count else {return nil}
        
        return menus[index]
    }
    
    func rowHeigh() -> Int {
        return 60
    }
}

