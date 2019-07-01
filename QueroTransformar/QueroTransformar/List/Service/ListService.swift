//
//  ListService.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

struct ListService {
    
    func requestList(completion: @escaping (Bool, List?) -> Void) {
        APIService.request(urlPath: "", method: .get, parameters: nil) { (data, error) in
            guard let data = data else {
                //request error
                completion(false, nil)
                return
            }
            
            //print(String(bytes: data, encoding: .utf8))
            
            let decoder = JSONDecoder()
            do {
                let items = try decoder.decode(List.self, from: data)
                completion(true, items)
            } catch {
                //decoding error
                completion(false, nil)
            }
        }
    }
}
