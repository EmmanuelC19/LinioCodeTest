//
//  LibraryAPI.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation
import SVProgressHUD

class LibraryAPI {
	
	static let sharedInstance = LibraryAPI()
	
	
	func getFavorites(Success onSuccess:@escaping ([WishList]) -> (), onError:@escaping (String) -> ()) {
		
		HTTPClient.sharedInstance.doRequest(method: "", type: "GET", parameters: [:], onSuccess: { (data) in
			if data.count != 0 {
				let response = Utils.getArrayOfWishList(dictionaryArray: data as! [Dictionary<String, AnyObject>])
				onSuccess(response)
			} else {
				onError(data as! String)
			}
			
		}, onError: {(error) in
			onError(error.description)
		})
	}
	
	
}
