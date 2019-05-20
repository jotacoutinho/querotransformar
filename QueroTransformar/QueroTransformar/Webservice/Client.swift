//
//  Webservices.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 13/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

class Client{
    
    static let shared = Client()
    var session: URLSession
    var itemList: Array<Any> = Array()
    var item: EntityItem?
    var comments: [EntityComment]?
    
    
    fileprivate init(){
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func getList(completionHandler: @escaping (_ success : Bool) -> Void){
        let urlString = "http://dev.4all.com:3003/tarefa"
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: urlString) as! URL
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        dataTask(with: request as URLRequest){
            (statusCode, data) in
            
            switch (statusCode) {
            case 200:
                
                guard let info = Coder().decodeFromJSONData(data: data, type: Constants.Tarefa.self) else {
                    //err parsing data
                    completionHandler(false)
                    return
                }
                
                //parse info.attributes
                //titulo = info.titulo
                //
                //...
                
                let itemArray : Array<Any> = info.lista
                print(itemArray)
                self.itemList = itemArray
                completionHandler(true)
                break
            case 400:
                completionHandler(false)
                //bad request
                break
            default:
                print("GET request got response \(statusCode)")
                completionHandler(false)
            }
            }.resume()
    }
    
    func getItem(id: String, completionHandler: @escaping (_ success : Bool) -> Void){
        //FIXME: add id
        let urlString = "http://dev.4all.com:3003/tarefa/\(id)"
        print("requesting url: \(urlString)")
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: urlString) as! URL
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        dataTask(with: request as URLRequest){
             (statusCode, data) in
            
            switch (statusCode) {
                case 200:
                    
                    guard let info = Coder().decodeFromJSONData(data: data, type: Constants.Item.self) else {
                        //err parsing data
                        completionHandler(false)
                        return
                    }
                    
                    //print(info)
                    
                    //parsing retrived data
                    var commentsArray = Array<EntityComment>()
                    info.comentarios.forEach{
                        comment in
                        
                        let currentComment = EntityComment(urlFoto: comment.urlFoto, nome: comment.nome, nota: comment.nota, titulo: comment.titulo, comentario: comment.comentario)
                        
                        commentsArray.append(currentComment)
                    }
                    
                    self.item = EntityItem(id: info.id, cidade: info.cidade, bairro: info.bairro, urlFoto: info.urlFoto, urlLogo: info.urlLogo, titulo: info.titulo, telefone: info.telefone, texto: info.texto, endereco: info.endereco, latitude: info.latitude, longitude: info.longitude, comentarios: commentsArray)
                    
                    completionHandler(true)
                    break
                case 400:
                    //bad request
                    completionHandler(false)
                    break
                default:
                    completionHandler(false)
                    print("GET request got response \(statusCode)")
                }
        }.resume()
    }
    
    fileprivate func dataTask(with request: URLRequest, completionHandler: @escaping(_ status: Int?, _ data: Data?) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) {
            (data, response, error)  in
//            print(data)
//            print(response)
//            print(error)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, let data = data else {
                completionHandler(nil, nil)
                return
            }
            completionHandler(statusCode, data)
        }
    }
}

