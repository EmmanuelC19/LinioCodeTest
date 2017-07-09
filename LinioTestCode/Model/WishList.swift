//
//  WishList.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation

class WishList: NSObject {
	
	var id : Int
	var name : String
	var descriptions: String
	var defaultStatus : Bool
	var owner : Owner
	var createdAt : String
	var visibility : String
	var products : [Product]
	
	init(dictionary: Dictionary<String, AnyObject>) {
		id = dictionary["id"] as? Int ?? -1
		name = dictionary["name"] as? String ?? ""
		descriptions = dictionary["description"] as? String ?? ""
		defaultStatus = dictionary["default"] as? Bool ?? false
		owner = Owner(dictionary:dictionary["owner"] as! Dictionary<String, AnyObject>)
		createdAt = dictionary["createdAt"] as? String ?? ""
		visibility = dictionary["visibility"] as? String ?? ""
		products = Utils.getArrayOfProducts(dictionary: dictionary["products"] as! Dictionary<String, AnyObject>)
	}
	

	
	
	
}
