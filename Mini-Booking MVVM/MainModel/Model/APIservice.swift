//
//  APIservice.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 19.02.2021.
//

import Foundation
import Moya

enum APIService{
    case getHotelsList
    case getHotelPicture(id: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .getHotelsList:
            return URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json")!
        case .getHotelPicture(let id):
            return URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(id).jpg")!
        }
        
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
