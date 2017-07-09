//
//  LibraryAPI.swift
//  LinioTestCode
//
//  Created by Emmanuel Casañas Cruz on 7/9/17.
//  Copyright © 2017 Emmanuel Cruz. All rights reserved.
//

import Foundation
//import SVProgressHUD

class LibraryAPI {
	
	static let sharedInstance = LibraryAPI()
	
	
	func getFavorites(Success onSuccess:@escaping (String) -> (), onError:@escaping (String) -> ()) {
		
		HTTPClient.sharedInstance.doRequest(method: "", type: "GET", parameters: [:], onSuccess: { (data) in
			if data.length != 0 {
				onSuccess(data as! String)
			} else {
				onError(data as! String)
			}
			
		}, onError: {(error) in
			onError(error.description)
		})
	}
	
	
	
	
//	func getAvailablePoints (Success onSuccess:@escaping (String) -> (), onError: @escaping (ErrorCoca) -> ()) {
//		HTTPClient.sharedInstance.doRequest(method: "ShopperInformation/GetBalance", type: "GET", parameters: nil, onSuccess: { (data) in
//			if let serviceResponse = data["respuesta"] as? Dictionary<String, AnyObject> {
//				let response = RespuestaServicio(dictionary: serviceResponse)
//				if(response.codigoRespuesta == 0){
//					let dataDetail = data as? Dictionary<String, AnyObject>
//					let totalPoints = dataDetail?["saldoPuntos"] as? String
//					onSuccess(totalPoints!)
//				} else if (response.codigoRespuesta == 3) {
//					UserSettings.logOutDevice()
//				} else {
//					onError(ErrorCoca(id:response.codigoRespuesta, titleError:"Error", messageError: response.mensaje))
//				}
//			} else {
//				onError(ErrorCoca(id:1919, titleError:"Error inesperado.", messageError: "Se produjo un error, intenta más tarde"))            }
//		}, onError: {(error) in
//			var errorMesage = "Unexpected"
//			if (error.localizedDescription != "") {
//				errorMesage = error.localizedDescription
//			}
//			onError(ErrorCoca(id:error.code, titleError:error.domain, messageError: errorMesage))
//		})
//		
//	}
	
	
}
