//
//  MainViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 06/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let topCellId = "topCellId"
    let bottomCellId = "bottomCellId"
    var navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.lightGray

        collectionView.register(TopCell.self, forCellWithReuseIdentifier: "topCellId")
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: "bottomCellId")
        
        //nav bar setup
        configureNavBar()
        collectionView.addSubview(self.navBar)
    }
    
    @objc func pressedBackButton(){
        self.dismiss(animated: true)
    }
    
    func configureNavBar(){
        //navigation items
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .plain, target: self, action: #selector(self.pressedBackButton))
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_button"), style: .plain, target: self, action: #selector(self.pressedBackButton))
        
        //title setup (image + text)
        let titleView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = "City - Neighborhood"
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.center = titleView.center
        titleLabel.textAlignment = NSTextAlignment.center
    
        //image's aspect ratio
        let locationTitleImage = UIImageView(image: UIImage(named: "location_white"))
        let imageAspect = locationTitleImage.image!.size.width / locationTitleImage.image!.size.height
        
        //image frame immediately before the text
        let imageX = titleLabel.frame.origin.x - titleLabel.frame.size.height * imageAspect
        let imageY = titleLabel.frame.origin.y
        let imageWidth = titleLabel.frame.size.height * imageAspect
        let imageHeight = titleLabel.frame.size.height
        
        locationTitleImage.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        locationTitleImage.contentMode = UIView.ContentMode.scaleAspectFit
        
        //adding views
        titleView.addSubview(locationTitleImage)
        titleView.addSubview(titleLabel)
        titleView.sizeToFit()
        navItem.titleView = titleView
    
        //nav bar configuration
        let height = UINavigationController().navigationBar.frame.size.height
        self.navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        self.navBar.barTintColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        self.navBar.tintColor = .white
        self.navBar.items = [navItem]
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //multiple cell layouts for main collection view
        if(indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCellId", for: indexPath)
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCellId", for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {   
        
        if(indexPath.item == 0){
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
        } else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
}

class BottomCell: UICollectionViewCell {
    var viewFrame : CGRect = CGRect()
    override init(frame: CGRect){
        super.init(frame: frame)
        viewFrame = frame
        self.backgroundColor = .white
        self.contentView.isUserInteractionEnabled = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let callButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "call_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .red
        return button
    }()
    
    let servicesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "services_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
        return button
    }()
    
    let locationButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "location_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .red
        return button
    }()
    
    let commentsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "comments_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
        return button
    }()
    
    let favoritesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favorites_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .red
        return button
    }()
    
    let callLabel : UILabel = {
        let label = UILabel()
        label.text = "Ligar"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let servicesLabel : UILabel = {
        let label = UILabel()
        label.text = "Serviços"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Endereço"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "Comentários"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let favoritesLabel : UILabel = {
        let label = UILabel()
        label.text = "Favoritos"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let line1px : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textDescription : UILabel = {
        let text = UILabel()
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa."
        text.font = UIFont.systemFont(ofSize: 14)
        text.numberOfLines = 0
        text.textAlignment = .justified
        text.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let mapView : MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let mapLabel : UILabel = {
        let label = UILabel()
        label.text = "Rua dos Mockados, 41"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    //adds subviews + constraints setup
    func setupViews(){
        
        let padding = 16
        
        //adding views
        addSubview(line1px)
        addSubview(textDescription)
        addSubview(mapView)
        addSubview(mapLabel)
    
        addSubview(callButton)
        addSubview(servicesButton)
        addSubview(locationButton)
        addSubview(commentsButton)
        addSubview(favoritesButton)
    
        addSubview(callLabel)
        addSubview(servicesLabel)
        addSubview(locationLabel)
        addSubview(commentsLabel)
        addSubview(favoritesLabel)
        
        //constraint setup for buttons
        //FIXME: 50px is the image size for 1x | only if all buttons have the same size
        //TODO: fix "?? 50" to imageAppropriateSize, where imageAppropriateSize == image.size (based on device)
        let buttonSize = callButton.currentImage?.size.width ?? CGFloat(integerLiteral: 50)
        let buttonSpacing = (self.frame.size.width - (5 * buttonSize) - CGFloat(2 * padding)) / 4
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-\(buttonSpacing)-[v1]-\(buttonSpacing)-[v2]-\(buttonSpacing)-[v3]-\(buttonSpacing)-[v4]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":callButton, "v1":servicesButton, "v2":locationButton, "v3":commentsButton, "v4":favoritesButton]))
    
        //constraint setup for labels
        callLabel.centerXAnchor.constraint(equalTo: callButton.centerXAnchor).isActive = true
        servicesLabel.centerXAnchor.constraint(equalTo: servicesButton.centerXAnchor).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor).isActive = true
        commentsLabel.centerXAnchor.constraint(equalTo: commentsButton.centerXAnchor).isActive = true
        favoritesLabel.centerXAnchor.constraint(equalTo: favoritesButton.centerXAnchor).isActive = true
        
        //constraint setup for 1px line
        let heightConstraintLine1px = line1px.heightAnchor.constraint(equalToConstant: 1)
        
        addConstraints([heightConstraintLine1px])
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": line1px]))
        
        //constraint setup for text description
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": textDescription]))
        
        //constraint setup for map view
        let heightConstraintMapView = mapView.heightAnchor.constraint(equalToConstant: 100)
        addConstraint(heightConstraintMapView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mapView]))
        
        //constraint setup for map label
        let widthConstraintMapLabel = mapLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width)
        addConstraint(widthConstraintMapLabel)
        
        //other views
        //addConstraints
        //...
        
        //constraint setup for cell structure (vertical padding)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": callButton, "v1": callLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": servicesButton, "v1": servicesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": locationButton, "v1": locationLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": commentsButton, "v1": commentsLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": favoritesButton, "v1": favoritesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabel]))
    }
}

class TopCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        self.contentView.isUserInteractionEnabled = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pictureImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
//        label.backgroundColor = .blue
        return label
    }()
    
    func setupViews(){
        
        addSubview(pictureImageView)
        addSubview(titleLabel)
    
        //TODO: constraint setup for imageview (view only, no image yet) --> Add image + constraints to fill
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": pictureImageView]))
        
        //constraint setup for label
        let labelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        addConstraint(labelBottomConstraint)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": titleLabel]))
    }
}
