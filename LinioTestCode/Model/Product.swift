//
//  Product.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation

class Product: NSObject {
	
	var id : Int
	var name : String
	var wishListPrice : Int
	var slug : String
	var url : String
	var image : String
	var linioPlusLevel : Int
	var conditionType : String
	var freeShipping : Bool
	var imported : Bool
	var active : Bool
	
	init(dictionary: Dictionary<String, AnyObject>) {
		id = dictionary["id"] as? Int ?? -1
		name = dictionary["name"] as? String ?? ""
		wishListPrice = dictionary["wishListPrice"] as? Int ?? 0
		slug = dictionary["slug"] as? String ?? ""
		url = dictionary["url"] as? String ?? ""
		image = dictionary["image"] as? String ?? ""
		linioPlusLevel = dictionary["linioPlusLevel"] as? Int ?? -1
		conditionType = dictionary["conditionType"] as? String ?? ""
		freeShipping = dictionary["freeShipping"] as? Bool ?? false
		imported = dictionary["imported"] as? Bool ?? false
		active = dictionary["active"] as? Bool ?? false
	}
}
