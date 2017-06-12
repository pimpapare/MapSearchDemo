//
//  APIRequest.swift
//  AlamofireRouter
//
//  Created by Khemmachart Chutapetch on 1/8/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

public class APIRequest {
    public typealias completionHandler = (AnyObject?, Error?) -> Void
    
    public static func request(withRouter router: MapRouter, withHandler handler: @escaping completionHandler) -> Request?  {
        return Alamofire.request(router).responseJSON(completionHandler: { response in
            
            debugPrint("❤️",response)
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let JSON):
                ResponseHandler(JSON: JSON as? [String : AnyObject], router: router, completionHandler: handler)
            case .failure( _):
                handler(nil,APIError.init(status_code: statusCode ?? 0))
            }
        })
    }
    
    public static func ResponseHandler(JSON: [String : AnyObject]?, router: MapRouter, completionHandler: APIRequest.completionHandler) {
        
        if let JSON = JSON {
            let instance: BaseModel = router.responseClass.init(withDictionary: JSON)
            completionHandler(instance, nil)
        }else{
            completionHandler(nil,nil)// already debug error
        }
    }
}

public class APIError: LocalizedError {
    
    var status_code = 0
    
    required convenience public init?(status_code: Int) {
        self.init()
        self.status_code = status_code
    }
    
    public var errorDescription: String?
    {
        /*  switch status_code {
         case 471:
         return NSLocalizedString("error_471", comment: "error")
         case 472:
         return NSLocalizedString("error_472", comment: "error")
         case 473:
         return NSLocalizedString("error_473", comment: "error")
         case 474:
         return NSLocalizedString("error_474", comment: "error")
         case 475:
         return NSLocalizedString("error_475", comment: "error")
         case 401:
         return NSLocalizedString("error_401", comment: "error")
         case 403:
         return NSLocalizedString("error_403", comment: "error")
         case 404:
         return NSLocalizedString("error_404", comment: "error")
         case 405:
         return NSLocalizedString("error_405", comment: "error")
         case 409:
         return NSLocalizedString("error_409", comment: "error")
         case 500:
         return NSLocalizedString("error_500", comment: "error")
         case 501:
         return NSLocalizedString("error_501", comment: "error")
         case 204:
         return NSLocalizedString("error_204", comment: "error")
         default:
         return NSLocalizedString("error_text", comment: "error")
         }
         //        return "\(origin) - code:\(status)(\(status_code)) description:\(descriptionString)"
         */
        return .errorTitle
    }
}

