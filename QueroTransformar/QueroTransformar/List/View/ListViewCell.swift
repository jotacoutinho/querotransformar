//
//  TableViewCell.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 26/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var label : UILabel! {
        didSet{
            label.font = UIFont.systemFont(ofSize: 16)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    func setText(text: String) {
        self.label.text = text
    }

}
