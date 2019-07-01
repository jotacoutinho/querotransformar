//
//  MainViewHeader.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewHeader: UITableViewCell {
    
    @IBOutlet weak var headerPictureImageView : UIImageView! {
        didSet{
            headerPictureImageView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var headerTitleLabel : UILabel! {
        didSet{
            headerTitleLabel.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet weak var headerLogoImageView : UIImageView! {
        didSet{
            headerLogoImageView.backgroundColor = UIColor.white
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
    
    
    func configure(for item: Item){
        self.headerTitleLabel.text = item.titulo
        self.headerPictureImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: item.urlFoto)!))
        self.headerLogoImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: item.urlLogo)!))
    }
    
}
