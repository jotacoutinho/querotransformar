//
//  Main.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

struct Item: Codable{
    let id: String
    let cidade: String
    let bairro: String
    let urlFoto: String
    let urlLogo: String
    let titulo: String
    let telefone: String
    let texto: String
    let endereco: String
    let latitude : Float
    let longitude : Float
    let comentarios : [Comments]
}

struct Comments: Codable{
    let urlFoto: String
    let nome: String
    let nota: Int
    let titulo: String
    let comentario: String
}

//struct Main: Codable{
//
//    //FIXME: it may not work this way XD
//    struct Item: Codable{
//        let id: String
//        let cidade: String
//        let bairro: String
//        let urlFoto: String
//        let urlLogo: String
//        let titulo: String
//        let telefone: String
//        let texto: String
//        let endereco: String
//        let latitude : Float
//        let longitude : Float
//        let comentarios : [Comments]
//    }
//
//    struct Comments: Codable{
//        let urlFoto: String
//        let nome: String
//        let nota: Int
//        let titulo: String
//        let comentario: String
//    }
//}
