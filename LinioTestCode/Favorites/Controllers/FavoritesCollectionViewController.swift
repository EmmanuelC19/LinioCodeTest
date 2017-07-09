//
//  FavoritesCollectionViewController.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/8/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import UIKit

private let reuseIdentifierSnap = "SnapshotCell"
private let reuseIdentifierFav = "FavoritesCell"

class FavoritesCollectionViewController: UICollectionViewController {
	
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
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierSnap, for: indexPath)
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierFav, for: indexPath)
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
	
	func requestFavorites() {
		LibraryAPI.sharedInstance.getFavorites(Success: { (response) in
			self.dataSourceSectionOne = response
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
		}) { (Error) in
			print(Error)
		}
	}
	


}
