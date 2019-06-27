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
        }
    }
    
    @IBOutlet weak var noteImageView : UIImageView! {
        didSet{
        }
    }
    
    @IBOutlet weak var userNameLabel : UILabel! {
        didSet{
        }
    }
    
    @IBOutlet weak var titleLabel : UILabel! {
        didSet{
        }
    }
    
    @IBOutlet weak var commentTextView : UITextView! {
        didSet{
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
}
