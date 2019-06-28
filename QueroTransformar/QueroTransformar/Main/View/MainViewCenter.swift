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
    
    
    @IBOutlet weak var descriptionLabel : UILabel! {
        didSet{
            descriptionLabel.backgroundColor = UIColor.clear
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
    
    func configure(for item: Item){
        self.descriptionLabel.text = item.texto
        self.mapLabel.text = item.endereco
        
        //map setup
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly:item.latitude) ?? 0.0, longitude: CLLocationDegrees(exactly:item.longitude) ?? 0.0)
        self.mapView.addAnnotation(annotation)
        self.mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
    }
    
}
