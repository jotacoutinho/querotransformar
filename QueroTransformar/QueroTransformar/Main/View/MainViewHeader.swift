//
//  MainViewHeader.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class MainViewHeader: UITableViewCell {
    
    @IBOutlet weak var headerLogoImageView : UIImageView! {
        didSet{
        }
    }
    
    @IBOutlet weak var headerTitleLabel : UILabel! {
        didSet{
        }
    }
    @IBOutlet weak var headerPictureImageView : UIImageView! {
        didSet{
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
}
