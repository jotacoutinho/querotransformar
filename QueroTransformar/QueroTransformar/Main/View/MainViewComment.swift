//
//  MainViewComment.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class MainViewComment: UITableViewCell {
    
    @IBOutlet weak var userPictureImageView : UIImageView! {
        didSet{
            //userPictureImageView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var noteImageView : UIImageView! {
        didSet{
            //noteImageView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var userNameLabel : UILabel! {
        didSet{
            userNameLabel.text = "Nome"
            userNameLabel.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var titleLabel : UILabel! {
        didSet{
            titleLabel.text = "Titulo"
            titleLabel.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var commentLabel : UILabel! {
        didSet{
            commentLabel.backgroundColor = UIColor.clear
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
}
