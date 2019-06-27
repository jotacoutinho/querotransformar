//
//  MainViewHeader.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class MainViewHeader: UITableViewCell {
    
    @IBOutlet weak var headerPictureImageView : UIImageView! {
        didSet{
        }
    }
    
    @IBOutlet weak var headerTitleLabel : UILabel! {
        didSet{
            headerTitleLabel.text = "Título"
            headerTitleLabel.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet weak var headerLogoImageView : UIImageView! {
        didSet{
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.bringSubviewToFront(headerLogoImageView)
    }
    
}
