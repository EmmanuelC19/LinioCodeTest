//
//  InterfaceHelper.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation
import UIKit

enum device : CGFloat {
	case iPhone4 = 480
	case iPhonne5 = 568
	case iPhone7 = 667
	case iPhone7p = 736
	
	var value: CGFloat {
		return self.rawValue
	}
	
}

public class InterfaceHelper {
	
	class func getSizeForSnapshotCell() -> CGSize {
		let screenSize: CGRect = UIScreen.main.bounds
		
		switch screenSize.height {
		case device.iPhone4.rawValue:
			return CGSize(width: 124, height: 128)
		case device.iPhonne5.rawValue:
			return CGSize(width: 134, height: 138)
		case device.iPhone7.rawValue:
			return CGSize(width: 174, height: 178)
		case device.iPhone7p.rawValue:
			return CGSize(width: 174, height: 178)
		default:
			return CGSize(width: 174, height: 178)
		}
		
	}
	
	class func getSizeForFavoriteCell() -> CGSize {
		let screenSize: CGRect = UIScreen.main.bounds
		
		switch screenSize.height {
		case device.iPhone4.rawValue:
			return CGSize(width: 124, height: 124)
		case device.iPhonne5.rawValue:
			return CGSize(width: 134, height: 134)
		case device.iPhone7.rawValue:
			return CGSize(width: 174, height: 174)
		case device.iPhone7p.rawValue:
			return CGSize(width: 174, height: 174)
		default:
			return CGSize(width: 174, height: 174)
		}
	}
	
	class func fixScreenForSmallDevices( contriants: ([NSLayoutConstraint],[NSLayoutConstraint])){
		let screenSize: CGRect = UIScreen.main.bounds
		if screenSize.height == device.iPhonne5.rawValue {
			for constraint in contriants.0 {
				constraint.constant = 70
			}
			
			for constraint in contriants.1 {
				constraint.constant = 28
			}
		}
	}

}
