//
//  EntityComments.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 15/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

class EntityComment{
    
    var urlFoto: String = String()
    var nome: String = String()
    var nota: Int = Int()
    var titulo: String = String()
    var comentario: String = String()
    
    convenience init(urlFoto: String, nome: String, nota: Int, titulo: String, comentario: String) {
        
        self.init()
        self.urlFoto = urlFoto
        self.nome = nome
        self.nota = nota
        self.titulo = titulo
        self.comentario = comentario
    }
    
}
