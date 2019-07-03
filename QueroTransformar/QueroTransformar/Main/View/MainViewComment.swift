//
//  MainViewComment.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewComment: UITableViewCell {
    
    @IBOutlet weak var userPictureImageView : UIImageView! {
        didSet{
            userPictureImageView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var noteImageView : UIImageView! {
        didSet{
            noteImageView.backgroundColor = UIColor.clear
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
    
    func configure(for comment: Comments){
        self.userNameLabel.text = comment.nome
        self.titleLabel.text = comment.titulo
        self.commentLabel.text = comment.comentario
        self.userPictureImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: comment.urlFoto)!))
        switch(comment.nota){
        case 1:
            self.noteImageView.image = UIImage(named: "1star_nobg")
            break
        case 2:
            self.noteImageView.image = UIImage(named: "2star_nobg")
            break
        case 3:
            self.noteImageView.image = UIImage(named: "3star_nobg")
            break
        case 4:
            self.noteImageView.image = UIImage(named: "4star_nobg")
            break
        case 5:
            self.noteImageView.image = UIImage(named: "5star_nobg")
            break
        default:
            self.noteImageView.image = UIImage(named: "5star_nobg")
        }
        self.backgroundColor = UIColor.red
    }
}
