//
//  MainViewCenter.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit
import MapKit

class MainViewCenter: UITableViewCell {
    
    @IBOutlet weak var callButton : UIButton! {
        didSet{
        }
    }
    
    @IBOutlet weak var servicesButton : UIButton! {
        didSet{
        }
    }
    
    @IBOutlet weak var locationButton : UIButton! {
        didSet{
        }
    }
    
    @IBOutlet weak var commentsButton : UIButton! {
        didSet{
        }
    }
    
    @IBOutlet weak var favoritesButton : UIButton! {
        didSet{
        }
    }
    
//    @IBOutlet weak var callLabel : UILabel! {
//        didSet{
//        }
//    }
//
//    @IBOutlet weak var servicesLabel : UILabel! {
//        didSet{
//        }
//    }
//
//    @IBOutlet weak var locationLabel : UILabel! {
//        didSet{
//        }
//    }
//
//    @IBOutlet weak var commentsLabel : UILabel! {
//        didSet{
//        }
//    }
//
//    @IBOutlet weak var favoritesLabel : UILabel! {
//        didSet{
//        }
//    }
    
    @IBOutlet weak var descriptionTextView : UITextView! {
        didSet{
        }
    }
    
    @IBOutlet weak var mapView : MKMapView! {
        didSet{
        }
    }
    
    @IBOutlet weak var mapLabel : UILabel! {
        didSet{
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    

    
}
