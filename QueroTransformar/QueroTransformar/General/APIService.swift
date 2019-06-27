//
//  APIService.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation
import Alamofire

class APIService{

    static func request(urlPath: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, completion: @escaping ((Data?, Error?) -> Void)) {
        let url =  Config.BaseURL + urlPath
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: Config.defaultHeaders)
            .validate()
            .responseJSON { response in
                switch response.result {
                    case .success:
                        completion(response.data, nil)
                    case .failure:
                        completion(nil, response.error)
                }
        }
    }
}
