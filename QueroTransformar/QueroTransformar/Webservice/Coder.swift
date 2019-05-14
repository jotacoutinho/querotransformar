//
//  Coder.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 13/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

class Coder {
    
    func decodeFromJSONData<T: Codable>(data: Data?, type: T.Type) -> T?{
        guard let data = data else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode(type, from: data)
            print("Successfully decoded data of type \(type).")
            return decodedData
        }
        catch {
            print("Error while getting data of \(type).\n\(error.localizedDescription)")
            // Uncomment the following print to see more details:
            //print("Error -> \(error)")
        }
        
        return nil
    }
}
