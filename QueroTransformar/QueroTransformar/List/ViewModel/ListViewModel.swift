//
//  ListViewModel.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate: AnyObject{
    func didFinishLoadingItems(success: Bool)
}

class ListViewModel {
    weak var delegate: ListViewModelDelegate?
    private var _items: List?
    private var listService = ListService()
    
    var items: List? {
        get { return _items }
    }
    
    func loadItems() {
        //returns downloaded items
        listService.requestList(){
            success, data in
            
            if(success){
                self._items = data
            }
            
            self.delegate?.didFinishLoadingItems(success: success)
        }
    }
}
