//
//  MainViewModel.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 28/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: AnyObject{
    func didFinishLoadingContent(success: Bool)
}

class MainViewModel {
    weak var delegate: MainViewModelDelegate?
    private var _item: Item?
    private var mainService = MainService()
    
    var item: Item? {
        get { return _item }
    }
    
    func loadItem(id: String) {
        //returns downloaded content
        mainService.requestContent(for: id){
            success, data in
            
            if(success){
                self._item = data
            }
            
            self.delegate?.didFinishLoadingContent(success: success)
        }
    }
}
