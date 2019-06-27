//
//  Constants.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 13/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

class Constants {

    struct Tarefa: Codable{
        let lista : [String]
        
        enum CodingKeys: String, CodingKey {
            case lista
        }
    }
    
    
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

        enum CodingKeys: String, CodingKey {
            case id
            case cidade
            case bairro
            case urlFoto
            case urlLogo
            case titulo
            case telefone
            case texto
            case endereco
            case latitude
            case longitude
            case comentarios
        }
    }

    struct Comments: Codable{
        
        let urlFoto: String
        let nome: String
        let nota: Int
        let titulo: String
        let comentario: String
        
        enum CodingKeys: String, CodingKey {
            case urlFoto
            case nome
            case nota
            case titulo
            case comentario
        }
    }
}
