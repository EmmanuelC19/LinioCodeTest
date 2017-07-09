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
		var product : Product
		for element in dictionary {
			product = Product(dictionary: element.value as! Dictionary<String, AnyObject>)
			productsArray.append(product)
		}
		
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
	
	class func getAllProductsFrom (wishList : [WishList]) -> [Product] {
		var productsArray : [Product] = []
		for element in wishList {
			for product in element.products{
				productsArray.append(product)
			}
		}
		return productsArray
	}
	
	

	
	
}
