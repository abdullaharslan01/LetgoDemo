//
//  HomeVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - UI Elements
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    // MARK: - Properties
    
    var homeViewModel = HomeViewModel()

    // MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectinViewsSetUp()
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    // MARK:  - Functions
    
    
    func collectinViewsSetUp() {
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        categoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    
    
    // MARK: - Actions

   
    
    

}


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return homeViewModel.categoryNumberOfItemsInSection()
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
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case categoryCollectionView:
        
           
           
            return CGSize(width: (categoryCollectionView.frame.width/4), height: categoryCollectionView.frame.height)
            
        default:
            return CGSize()
        }
    }
    
    
}
