//
//  SnapshotCollectionViewCell.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import UIKit

class SnapshotCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var firstImage: UIImageView!
	@IBOutlet weak var secondImage: UIImageView!
	@IBOutlet weak var thirdImage: UIImageView!
	@IBOutlet weak var wishListName: UILabel!
	@IBOutlet weak var wishListCount: UILabel!
	

	@IBOutlet var ContraintsCollectionOne: [NSLayoutConstraint]!
	
	@IBOutlet var ContraintCollectionTwo: [NSLayoutConstraint]!
	
	override func awakeFromNib() {
		InterfaceHelper.fixScreenForSmallDevices(contriants: (ContraintsCollectionOne,ContraintCollectionTwo))
	}
	
    
}
