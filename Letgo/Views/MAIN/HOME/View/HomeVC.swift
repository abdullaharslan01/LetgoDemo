//
//  HomeVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class HomeVC: UIViewController {

    
    
    
    
    
    // MARK: - UI Elements
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    // MARK: - Properties
    
    var homeViewModel = HomeViewModel()
    
    var hasScrolled = false

    // MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        collectinViewsSetUp()
        getProductlist()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refleshScreen(notification:)), name: .refleshScreen, object: nil)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    // MARK:  - Functions
    
    
    @objc func refleshScreen(notification: NSNotification) {
        getProductlist()
    }
    
    func collectinViewsSetUp() {
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        
        productCollectionView.register(AdsCollectionViewCell.nib(), forCellWithReuseIdentifier: AdsCollectionViewCell.identifier)
        
        categoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    
    func getProductlist() {
        
        homeViewModel.getProductList {  result in
            
            if result == 0 {
                DispatchQueue.main.async{
                    self.showAlert(title: "Erorr", message: "There is a problem fetching products. Please check your internet connection", buttonTitle: "OK")
                }
            }
            else {
                DispatchQueue.main.async{
                    self.productCollectionView.reloadData()
                }
                    
                
            }
        }
        
        
    }
    
    // MARK: - Actions

   
    
    

}


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return homeViewModel.categoryNumberOfItemsInSection()
            
        case productCollectionView:
            return homeViewModel.productListyNumberOfItemsInSection()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: homeViewModel.categoryId(at: indexPath.row)!)
            return cell
        case productCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionViewCell.identifier, for: indexPath) as! AdsCollectionViewCell
            cell.configure(with: homeViewModel.productList[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueRoutes.detailVC.rawValue, sender: homeViewModel.productId(at: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueRoutes.detailVC.rawValue {
            if let destinationVC = segue.destination as? DetailVC {
                
                if let productItem = sender as? Product {
                    destinationVC.productUser = productItem

                }
                
            }
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case categoryCollectionView:
        
    
           
            return CGSize(width: (categoryCollectionView.frame.width/4), height: categoryCollectionView.frame.height)
    
        case productCollectionView:
            return CGSize(width: (productCollectionView.frame.width - 30) / 2, height: 250)

            
        default:
            return CGSize()
        }
    }
    
    
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       
        
        
        
        homeViewModel.getProductList(searchText: searchText) { state in
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
        
    }


}
