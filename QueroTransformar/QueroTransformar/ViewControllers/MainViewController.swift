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
    let headerId = "headerId"
    var navBar = UINavigationBar()
    let padding = 16
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.titulo ?? "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        //        label.backgroundColor = .blue
        return label
    }()
    
    let titleLabelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerPicture : UIImageView = {
        let view = UIImageView()
        //FIXME
        DispatchQueue.main.async{
            let data = try? Data(contentsOf: URL(string: (Client.shared.item?.urlFoto)!)!)
            print(Client.shared.item?.urlFoto)
            view.image = UIImage(data: data!)
            //view.image = UIImage(named: "favorites_button")
        }
        //view.image = UIImage(named: "favorites_button")
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.sizeToFit()
        view.backgroundColor = .blue
        return view
    }()
    
    let logoPicture : UIImageView = {
        let view = UIImageView()
        DispatchQueue.main.async{
            //FIXME
            let data = try? Data(contentsOf: URL(string: (Client.shared.item?.urlLogo)!)!)
            view.image = UIImage(data: data!)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)

        //collectionView.register(TopCell.self, forCellWithReuseIdentifier: "topCellId")
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: "bottomCellId")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        //nav bar setup
        configureNavBar()
        //collectionView.addSubview(self.navBar)
        
        //debug: printing downloaded item
//        print("Downloaded item id:\n")
//        print(Client.shared.item?.id)
        
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
        titleLabel.text = Client.shared.item?.cidade ?? "City"
        titleLabel.text?.append(" - ")
        titleLabel.text?.append(Client.shared.item?.bairro ?? "Neigborhood")
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellId, for: indexPath)
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {   
        
        if(indexPath.item == 0){
            //main cell
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else{
            //comments
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        //FIXME: setupViews() for header
        header.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        header.addSubview(self.navBar)
        header.addSubview(self.titleLabelView)
        header.addSubview(self.headerPicture)
        header.addSubview(self.logoPicture)
        
        //constraints
        self.navBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        self.titleLabelView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        self.headerPicture.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        //self.headerPicture.bottomAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
        self.headerPicture.widthAnchor.constraint(equalToConstant: navBar.frame.size.width)
        
        //let pictureHeight = collectionView.frame.size.height - navBar.frame.size.height - titleLabel.frame.size.height
        //self.headerPicture.heightAnchor.constraint(equalToConstant: 100)
        //self.headerPicture.sizeToFit()
        
        //FIXME
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1][v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.navBar, "v1": self.headerPicture, "v2": self.titleLabelView]))
        //header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.titleLabel]))
        
        //titlelabel view
        titleLabelView.addSubview(titleLabel)
        let widthConstraintMapLabel = titleLabelView.widthAnchor.constraint(equalToConstant: collectionView.frame.size.width)
        let heightConstraintMapLabel = titleLabelView.heightAnchor.constraint(equalToConstant: 60)
        header.addConstraints([widthConstraintMapLabel,heightConstraintMapLabel])
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": titleLabelView]))
        
        titleLabelView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.titleLabel]))
        titleLabelView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.titleLabel]))
        
        //FIXME: icon dimensions
        logoPicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoPicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoPicture.layer.cornerRadius = 50
        
        logoPicture.centerYAnchor.constraint(equalTo: self.titleLabelView.topAnchor).isActive = true
        //logoPicture.rightAnchor.constraint(equalTo: (self.navigationItem.rightBarButtonItem?.customView?.leftAnchor)!).isActive = true
        let leftPaddingConstraintForLogo = collectionView.frame.size.width - 100.0 - CGFloat(padding)
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftPaddingConstraintForLogo)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.logoPicture]))
        
        //header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-\(3*padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.logoPicture]))
        
        //FIXME
        //let logoOffset = collectionView.frame.size.width * 1/4
        //logoPicture.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: logoOffset)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
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
        text.text = Client.shared.item?.texto ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        text.font = UIFont.systemFont(ofSize: 16)
        text.numberOfLines = 0
        text.textAlignment = .justified
        text.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let mapView : MKMapView = {
        let map = MKMapView()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: Client.shared.item?.latitude  ?? 0.0) ?? 0.0, longitude: CLLocationDegrees(exactly: Client.shared.item?.longitude ?? 0.0) ?? 0.0)
        map.addAnnotation(annotation)
        map.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let mapLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.endereco ?? "Rua dos Mockados, 41"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let mapLabelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return view
    }()
    
    let mapLabelLocationIcon : UIImageView = {
        let view = UIImageView(image: UIImage(named: "location_button"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    //adds subviews + constraints setup
    func setupViews(){
        
        let padding = 16
        
        //adding views
        addSubview(line1px)
        addSubview(textDescription)
        addSubview(mapView)
        addSubview(mapLabelView)
        addSubview(mapLabelLocationIcon)
    
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
        let heightConstraintMapView = mapView.heightAnchor.constraint(equalToConstant: 150)
        addConstraint(heightConstraintMapView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mapView]))
        
        //constraint setup for map label view
        mapLabelView.addSubview(mapLabel)
        let widthConstraintMapLabel = mapLabelView.widthAnchor.constraint(equalToConstant: self.frame.size.width)
        let heightConstraintMapLabel = mapLabelView.heightAnchor.constraint(equalToConstant: 30)
        addConstraints([widthConstraintMapLabel,heightConstraintMapLabel])
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mapLabelView]))
        
        //constraint setup for map label
        mapLabel.centerYAnchor.constraint(equalTo: mapLabelView.centerYAnchor).isActive = true
        mapLabel.rightAnchor.constraint(equalTo: commentsLabel.rightAnchor).isActive = true
//        mapLabel.rightAnchor.constraint(equalTo: mapLabelLocationIcon.leftAnchor, constant: CGFloat(padding/2)).isActive = true
        
        //constraint setup for location icon on map label
        //FIXME: icon dimensions
        mapLabelLocationIcon.widthAnchor.constraint(equalToConstant: 50)
        mapLabelLocationIcon.heightAnchor.constraint(equalToConstant: 50)
        mapLabelLocationIcon.layer.cornerRadius = 25
        
        mapLabelLocationIcon.centerYAnchor.constraint(equalTo: mapLabelView.topAnchor).isActive = true
        mapLabelLocationIcon.leftAnchor.constraint(equalTo: favoritesLabel.leftAnchor).isActive = true
//        mapLabelLocationIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(padding/2)).isActive = true
    
        //other views
        //addConstraints
        //...
        
        //constraint setup for cell structure (vertical padding)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": callButton, "v1": callLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": servicesButton, "v1": servicesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": locationButton, "v1": locationLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": commentsButton, "v1": commentsLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": favoritesButton, "v1": favoritesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
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
        label.text = Client.shared.item?.titulo ?? "Mock Title"
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
