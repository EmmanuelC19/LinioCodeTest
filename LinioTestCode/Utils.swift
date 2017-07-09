//
//  Utils.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation


public class Utils {
	
	class func getArrayOfProducts (dictionary : Dictionary<String, AnyObject>) -> [Product] {
		var productsArray : [Product] = []
		
		return productsArray
	}
	
	class func getArrayOfWishList (dictionaryArray : [Dictionary<String, AnyObject>]) -> [WishList] {
		var wishListArray : [WishList] = []
		var wishList : WishList
		for element in dictionaryArray {
			wishList = WishList(dictionary: element)
			wishListArray.append(wishList)
		}
		return wishListArray
	}
	
	

	
	
}
