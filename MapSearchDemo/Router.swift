//
//  Router.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import Foundation
import Alamofire
public protocol MapRouter: URLRequestConvertible {
    
    var url: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }
    var responseClass: BaseModel.Type { get }
    func asURLRequest() throws -> URLRequest
}

public enum Router: MapRouter {
    
    case getPlaceList(location:String,radius:Int,key:String)
}

extension Router {
    
    public var url: String {
        return "https://maps.googleapis.com/maps/api/"
    }
    
    public var method: Alamofire.HTTPMethod {
        
        switch self {
        case .getPlaceList:
            return .get
        }
    }
    
    public var path: String {
        
        switch self {
        case .getPlaceList:
            return "place/nearbysearch/json"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        
        switch self {
        case .getPlaceList(let location,let radius,let key):
            let params = ["location": location,
                          "radius": radius,
                          "key":key] as [String : Any]
            return params as [String : AnyObject]
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .getPlaceList:
            return nil
        }
    }
    
    public var rawBody: NSData {
        switch self {
        default:
            return NSData()
        }
    }
    
    public var responseClass: BaseModel.Type {
        switch self {
        case .getPlaceList:
            return MapModel.self
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url + path)!)
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getPlaceList:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            return urlRequest
        }
    }
}

enum asd: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        
        return urlRequest!
    }
}
