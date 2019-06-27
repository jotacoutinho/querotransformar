//
//  MainService.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

struct MainService{
    
    static func requestContent(for id: String, completion: @escaping (Bool, Main?) -> Void) {
        APIService.request(urlPath: id, method: .get, parameters: nil) { (data, error) in
            guard let data = data else {
                //request error
                completion(false, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let info = try decoder.decode(Main.self, from: data)
                completion(true, info)
            } catch {
                //decoding error
                completion(false, nil)
            }
        }
    }
}
