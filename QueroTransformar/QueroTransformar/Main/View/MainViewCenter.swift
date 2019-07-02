//
//  MainViewCenter.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit
import MapKit

protocol MainViewCenterDelegate: AnyObject{
    func makeCall()
    func presentServices()
    func showAddress()
    func scrollToCommentSection()
}

class MainViewCenter: UITableViewCell {
    weak var delegate: MainViewCenterDelegate?
    
    @IBAction func makeCall(_ sender: Any) {
        self.delegate?.makeCall()
    }
    
    @IBAction func presentServices(_ sender: Any) {
         self.delegate?.presentServices()
    }
    
    @IBAction func showAddress(_ sender: Any) {
         self.delegate?.showAddress()
    }
    
    @IBAction func scrollToCommentSection(_ sender: Any) {
         self.delegate?.scrollToCommentSection()
    }
    
    @IBOutlet weak var descriptionLabel : UILabel! {
        didSet{
            descriptionLabel.backgroundColor = UIColor.clear
            descriptionLabel.numberOfLines = 0
            print(descriptionLabel.frame.height)
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
    
    func configure(for item: Item, withDelegate delegate: MainViewCenterDelegate){
        self.delegate = delegate
        self.descriptionLabel.text = item.texto
        self.mapLabel.text = item.endereco
        
        //map setup
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly:item.latitude) ?? 0.0, longitude: CLLocationDegrees(exactly:item.longitude) ?? 0.0)
        self.mapView.addAnnotation(annotation)
        self.mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
    }
    
}
