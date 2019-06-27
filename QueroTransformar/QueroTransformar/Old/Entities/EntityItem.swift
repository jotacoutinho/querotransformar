//
//  EntityListObject.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 15/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

class EntityItem{
    
    var id: String = String()
    var cidade: String = String()
    var bairro: String = String()
    var urlFoto: String = String()
    var urlLogo: String = String()
    var titulo: String = String()
    var telefone: String = String()
    var texto: String = String()
    var endereco: String = String()
    var latitude : Float = Float()
    var longitude : Float = Float()
    var comentarios : [EntityComment] = Array<EntityComment>()
    
    convenience init(id: String, cidade: String, bairro: String, urlFoto: String, urlLogo: String, titulo: String, telefone: String, texto: String, endereco: String, latitude: Float, longitude: Float, comentarios: [EntityComment]) {
        
        self.init()
        self.id = id
        self.cidade = cidade
        self.bairro = bairro
        self.urlFoto = urlFoto
        self.urlLogo = urlLogo
        self.titulo = titulo
        self.telefone = telefone
        self.texto = texto
        self.endereco = endereco
        self.latitude = latitude
        self.longitude = longitude
        self.comentarios = comentarios
    }
    
}
