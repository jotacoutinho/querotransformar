//
//  Config.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

struct Config{
    
    static var BaseURL: String {
        get {
            return "http://dev.4all.com:3003/tarefa/"
        }
    }
    
    static var defaultHeaders: [String: String] {
        return ["Content-Type" : "application/json",
                "Accept" :  "application/json"]
    }
    
}

