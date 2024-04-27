//
//  MyAddsVC.swift
//  Letgo
//
//  Created by abdullah on 24.04.2024.
//

import UIKit

class MyAddsVC: UIViewController {

    // MARK: - UI Elements
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var myAddsCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var myAddsViewModel = MyAddsViewModel()
    
    var favoriImageView:UIImageView?
    
    // MARK: - Life Cycle
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAddsCollectionView.dataSource = self
        myAddsCollectionView.delegate = self
        getMyProductList()
        NotificationCenter.default.addObserver(self, selector: #selector(refleshScreen(notification:)), name: .refleshScreen, object: nil)
        myAddsCollectionView.register(AdsCollectionViewCell.nib(), forCellWithReuseIdentifier: AdsCollectionViewCell.identifier)
        
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)

        favoriPageView()
    }
    
    @objc func refleshScreen(notification: NSNotification) {
        getMyProductList()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK:  - Functions
    
    func getMyProductList() {
        myAddsViewModel.getMyAdds { state in
            if state == 0 {
                DispatchQueue.main.async{
                    self.showAlert(title: "Erorr", message: "There is a problem fetching products. Please check your internet connection", buttonTitle: "OK")
                }
            }
            else {
                DispatchQueue.main.async{
                    self.myAddsCollectionView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Actions
    
    
    func favoriPageView() {
        let imageViewWidth = view.frame.width - 50
        let imageViewHeight = view.frame.height / 2
      
        
        favoriImageView = UIImageView(frame: CGRect(x: 0, y: segmentController.frame.maxY + 80 , width: imageViewWidth, height: imageViewHeight))
        favoriImageView!.image = UIImage(named: "favorite")
        favoriImageView!.contentMode = .scaleAspectFill
        favoriImageView!.clipsToBounds = true
        favoriImageView!.center.x = view.center.x
        view.addSubview(favoriImageView!)
        favoriImageView?.isHidden = true
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            myAddsCollectionView.isHidden = false
            favoriImageView?.isHidden = true
            break
        case 1:
            
            myAddsCollectionView.isHidden = true
            favoriImageView?.isHidden = false

            
        
                 
            
            break
        default:
            break
        }
        
        
    }
    
    
    
}


extension MyAddsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAddsViewModel.productNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionViewCell.identifier, for: indexPath) as! AdsCollectionViewCell
        
        cell.configure(with: myAddsViewModel.myProduct(at: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (myAddsCollectionView.frame.width - 30) / 2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueRoutes.detailVC2.rawValue, sender: myAddsViewModel.myProduct(at: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueRoutes.detailVC2.rawValue {
            if let destinationVC = segue.destination as? DetailVC {
                
                if let productItem = sender as? Product {
                    destinationVC.productUser = productItem
                    destinationVC.isMyAdds = true

                }
                
            }
        }
    }
    
}
