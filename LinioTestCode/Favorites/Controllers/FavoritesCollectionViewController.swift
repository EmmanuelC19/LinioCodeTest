//
//  FavoritesCollectionViewController.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/8/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import DZNEmptyDataSet

private let reuseIdentifierSnap = "SnapshotCell"
private let reuseIdentifierFav = "FavoritesCell"

class FavoritesCollectionViewController: UICollectionViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
	
	
	var dataSourceSectionOne : [WishList] = []
	var dataSourceSectionTwo : [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

		requestFavorites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
		
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		switch section {
		case 0:
			return dataSourceSectionOne.count
		case 1:
			return dataSourceSectionTwo.count
		default:
			return 0
		}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.section == 0 {
			 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierSnap, for: indexPath) as! SnapshotCollectionViewCell
			
			let selectedWishlist = dataSourceSectionOne[indexPath.row]
			let products = selectedWishlist.products
			cell.wishListName.text = selectedWishlist.name
			cell.wishListCount.text = String(selectedWishlist.products.count)
			cell.firstImage.sd_setImage(with: URL(string: products[0].image), placeholderImage: UIImage(named:"product_placeholder"))
			cell.secondImage.sd_setImage(with: URL(string: products[1].image), placeholderImage: UIImage(named:"product_placeholder"))
			cell.thirdImage.sd_setImage(with: URL(string: products[2].image), placeholderImage: UIImage(named:"product_placeholder"))
			
			return cell
			
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierFav, for: indexPath) as! FavoriteCollectionViewCell
			
			let selectedProduct = dataSourceSectionTwo[indexPath.row]
			
			cell.setupFavoriteCell(displayedProduct: selectedProduct)
			cell.productImage.sd_setImage(with: URL(string: selectedProduct.image), placeholderImage: UIImage(named:"product_placeholder"))
			
			return cell
		}
		

    }
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
			
		case UICollectionElementKindSectionHeader:
			
			//let section = indexPath.section
			
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
				return headerView
			
		case UICollectionElementKindSectionFooter:
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
			
			footerView.backgroundColor = .green;
			return footerView
			
		default:
			
			assert(false, "Unexpected element kind")
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
		
		let screenSize: CGRect = UIScreen.main.bounds

		if section == 0 {
			return CGSize(width: 0, height: 0)
		} else {
			if dataSourceSectionTwo.count > 0 {
				return CGSize(width: screenSize.width, height: 50)
			} else {
				return CGSize(width: 0, height: 0)
			}
		}
	
	}
	
	// Mark : DZNEmpty DataSetDelegate
	
	func image (forEmptyDataSet scrollView: UIScrollView) -> UIImage {
		return UIImage(named: "Favorites_Empty")!
	}
	
	func  title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
		return NSAttributedString.init(string: "¡Ups!")
	}
	
	func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
		return NSAttributedString.init(string: "Por el momento no hay favoritos para mostrar, asegúrate de tener una conexión estable")
		
		
	}
	
	func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
		
		let attrString = NSAttributedString (
			string: "Actualizar",
			attributes: [NSForegroundColorAttributeName: UIColor.white])
		
		return attrString
	}
	
	func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
		return nil
	}
	
	func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
			requestFavorites()
	}
	
	//Mark : Connection Methods 
	
	func requestFavorites() {
		
		if Reachability.isConnectedToNetwork() {
			SVProgressHUD.show(withStatus: "Actualizando favoritos...")
			LibraryAPI.sharedInstance.getFavorites(Success: { (response) in
				self.dataSourceSectionOne = response
				self.dataSourceSectionTwo = Utils.getAllProductsFrom(wishList: response)
				DispatchQueue.main.async {
					self.collectionView?.reloadData()
				}
				SVProgressHUD.dismiss()
			}) { (Error) in
				SVProgressHUD.showError(withStatus: Error.description)
			}
		} else {
			SVProgressHUD.showInfo(withStatus: "Necesitas Conexión a Internet para recuperar tus favoritos.")
		}
		
		
	}
	


}
