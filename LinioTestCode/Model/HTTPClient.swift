//
//  HTTPClient.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation

class HTTPClient: NSObject {
	
	static let sharedInstance = HTTPClient()
	
	private let SERVER = "https://gist.githubusercontent.com/la-ursic/3c5f25d5ee955ee9a6e493ac57884b9c/raw/5fab9af8e1f4db60419ba3a8da9f138cbb3a8461/Wish%2520lists"
	
	private let session: URLSession
	private let config: URLSessionConfiguration
	
	private var request: NSMutableURLRequest?
	private var credential: URLCredential?
	private var user: String?
	private var password: String?
	
	var params : Dictionary <String,AnyObject>?
	var file : Dictionary <String,AnyObject>?
	var token: String?
	
	
	override init(){
		config = URLSessionConfiguration.default
		
		session = URLSession(configuration: config)
		
	}
	
	func doRequest(method: String, type: String, parameters: Dictionary<String, AnyObject>?, onSuccess: @escaping (AnyObject) -> (), onError: @escaping (NSError) -> ()) {
		
		prepareRequestWithMethod(method: method, type: type)
		
		if !(parameters?.isEmpty)! {
			do {
				request!.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: [])
				// use anyObj here
			} catch {
				request!.httpBody = "".data(using: String.Encoding.utf8, allowLossyConversion: false)
			}
		}
		
		
		
		var task = URLSessionDataTask()
		task = session.dataTask(with: request! as URLRequest, completionHandler: {(data, response, error) in
			//print("DataTask didEnd")
			
			if error != nil {
				onError(error! as NSError)
				return
			}
			let httpResponse = response as! HTTPURLResponse
			if (httpResponse.statusCode != 200) {
				//print("Received HTTP StatusCode: \(httpResponse.statusCode)")
				onError(NSError(domain: "Unexpected", code: httpResponse.statusCode, userInfo: [:]))
				return
			}
			
			var responseDictionary: AnyObject?
			var responseObject: AnyObject?
			
			if (data?.count)! > 0 {
				
				do {
					if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: AnyObject]] {
						
						responseObject = dictionaryOK as AnyObject?
					}
				} catch {
					print(error)
				}
			}
			
			let emptyDict : [String:String] = [:]
			if responseObject == nil {
				
				responseDictionary = data as AnyObject
				
			}else {
				switch responseObject {
				case let validDict as Dictionary<String, AnyObject> :
					print(validDict)
					responseDictionary = responseObject as! Dictionary<String, AnyObject> as AnyObject?
				case let arrayOfElements as [[String: AnyObject]]:
					print(arrayOfElements)
					responseDictionary = arrayOfElements as AnyObject
				default:
					responseDictionary = emptyDict as AnyObject?
					print("Se recibio un objeto no manejable")
				}
				
			}
			onSuccess(responseDictionary!)
		})
		
		print("WillStart DataTask")
		task.resume()
	}
	

	
	func doRequest(method: String, parameters: Dictionary<String, AnyObject>, onSuccess: @escaping (AnyObject) -> Void, onError: @escaping (NSError) -> Void) {
		
		doRequest(method: method, type: "POST", parameters: parameters, onSuccess: onSuccess, onError: onError)
	}

	
	func prepareRequestWithMethod(method: String, type: String) {
		let url = NSURL(string: "\(SERVER)\(method)")
		
		print(url ?? "Empty URL")
		request = NSMutableURLRequest(url: url! as URL)
		request!.httpMethod = type
		request!.timeoutInterval = 60
	}
	
	
	func stringFromQueryParameters(queryParameters : Dictionary<String, AnyObject>) -> String {
		var parts: [String] = []
		for (name, value) in queryParameters {
			let part = NSString(format: "%@=%@",name.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!,value.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
			
			parts.append(part as String)
		}
		return parts.joined(separator: "&")
	}
	
}

protocol URLQueryParameterStringConvertible {
	var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
	/**
	This computed property returns a query parameters string from the given NSDictionary. For
	example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
	string will be @"day=Tuesday&month=January".
	@return The computed parameters string.
	*/
	var queryParameters: String {
		var parts: [String] = []
		for (key, value) in self {
			let part = NSString(format: "%@=%@",
			                    String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
			                    String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
			parts.append(part as String)
		}
		return parts.joined(separator: "&")
	}
	
}

extension NSURL {
	/**
	Creates a new URL by adding the given query parameters.
	@param parametersDictionary The query parameter dictionary to add.
	@return A new NSURL.
	*/
	func URLByAppendingQueryParameters(parametersDictionary : Dictionary<String, String>) -> NSURL {
		let URLString : NSString = NSString(format: "%@?%@", self.absoluteString!, parametersDictionary.queryParameters)
		return NSURL(string: URLString as String)!
	}
}

