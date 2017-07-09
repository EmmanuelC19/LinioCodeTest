//
//  FavoriteCollectionViewCell.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet weak var productImage: UIImageView!
	
	@IBOutlet weak var firstBadge: UIImageView!
	@IBOutlet weak var secondBadge: UIImageView!
	@IBOutlet weak var thirdBadge: UIImageView!
	@IBOutlet weak var fourthBadge: UIImageView!
	
	@IBOutlet weak var linioPlusHeigthConstraint: NSLayoutConstraint!
	
	

	
	func setupFavoriteCell (displayedProduct: Product) {
		if displayedProduct.linioPlusLevel == 1 {
			firstBadge.image = UIImage(named: "plus_badge")
		} else if displayedProduct.linioPlusLevel == 2{
			firstBadge.image = UIImage(named: "plus48_badge")
		} else {
			linioPlusHeigthConstraint.constant = 0
			firstBadge.isHidden = true
		}
		
		if displayedProduct.conditionType == "refurbished" {
			secondBadge.image = UIImage(named: "refubrished_badge")
		} else if displayedProduct.conditionType == "new" {
			secondBadge.image = UIImage(named: "new_badge")
		} else {
			secondBadge.isHidden = true
		}
		
		if displayedProduct.imported == true {
			thirdBadge.image = UIImage(named: "import_badge")
		} else {
			thirdBadge.isHidden = true
		}
		
		if displayedProduct.freeShipping == true {
			fourthBadge.image = UIImage(named: "free_shipping_badge")
		} else {
			fourthBadge.isHidden = true
		}
		
		
		
		
	}
}
