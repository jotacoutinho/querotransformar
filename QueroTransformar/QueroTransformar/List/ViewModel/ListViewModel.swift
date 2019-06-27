//
//  ListViewModel.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation

final class ListViewModel {
    private var _items: List?
    //private let listService = ListService()
    
    var items: List? {
        get { return _items }
    }
    
    func loadListItems() {
        //returns downloaded items
    }
}
