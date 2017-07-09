//
//  Owner.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation

class Owner: NSObject {
	
	var name : String
	var email : String
	var linioId : String
	
	init(dictionary: Dictionary<String, AnyObject>) {
		name = dictionary["name"] as? String ?? ""
		email = dictionary["email"] as? String ?? ""
		linioId = dictionary["linioId"] as? String ?? ""
	}

}
