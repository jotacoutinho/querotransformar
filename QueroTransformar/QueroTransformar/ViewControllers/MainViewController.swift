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
    
    let commentsCellId = "commentsCellId"
    let mainCellId = "mainCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    var navBar = UINavigationBar()
    let padding = 16

    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.titulo ?? "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let titleLabelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerPicture : UIImageView = {
        let view = UIImageView()
        DispatchQueue.main.async{
            //FIXME
            let data = try? Data(contentsOf: URL(string: (Client.shared.item?.urlFoto)!)!)
            print(Client.shared.item?.urlFoto)
            view.image = UIImage(data: data!)
        }
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
        
        //collectionView.backgroundColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        collectionView.backgroundColor = .white
        
        //cells register
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentsCellId)
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: mainCellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //nav bar setup
        configureNavBar()
        
        //notifications for button actions
        NotificationCenter.default.addObserver(self, selector: #selector(callAction), name: NSNotification.Name(rawValue: "call"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(servicesAction), name: NSNotification.Name(rawValue: "services"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(locationAction), name: NSNotification.Name(rawValue: "location"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(commentsAction), name: NSNotification.Name(rawValue: "comments"), object: nil)
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
        titleLabel.font = UIFont.systemFont(ofSize: 14)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellId, for: indexPath)
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentsCellId, for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (Client.shared.item?.comentarios.count ?? 0) + 1
        //return 2
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //FIXME: dynamic heights
        if(indexPath.item == 0){
            //main cell
            switch(Client.shared.item?.id){
            case "1":
                return CGSize(width: collectionView.frame.width, height: 410.0)
            case "b":
                return CGSize(width: collectionView.frame.width, height: 368.0)
            case "c33":
                return CGSize(width: collectionView.frame.width, height: 392.0)
            case "ultimo":
                return CGSize(width: collectionView.frame.width, height: 410.0)
            default:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            }
        } else{
            //comments
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
            setupHeaderViews(header: header)
            return header
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
    }
    
    func setupHeaderViews(header: UICollectionReusableView){
        //adding subviews
        header.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        header.addSubview(self.navBar)
        header.addSubview(self.titleLabelView)
        header.addSubview(self.headerPicture)
        header.addSubview(self.logoPicture)
        
        //header constraints setup (vertical)
        self.navBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        self.titleLabelView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        self.headerPicture.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        self.headerPicture.widthAnchor.constraint(equalToConstant: navBar.frame.size.width)
        
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1][v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.navBar, "v1": self.headerPicture, "v2": self.titleLabelView]))
        
        //constraint setup for titlelabelView
        titleLabelView.addSubview(titleLabel)
        let widthConstraintMapLabel = titleLabelView.widthAnchor.constraint(equalToConstant: collectionView.frame.size.width)
        let heightConstraintMapLabel = titleLabelView.heightAnchor.constraint(equalToConstant: 60)
        
        header.addConstraints([widthConstraintMapLabel,heightConstraintMapLabel])
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": titleLabelView]))
        
        //constraint setup for titleLabel
        titleLabelView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.titleLabel]))
        titleLabelView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.titleLabel]))
        
        //constraint setup for logo picture
        //FIXME: icon dimensions
        logoPicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoPicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoPicture.layer.cornerRadius = 50
        
        logoPicture.centerYAnchor.constraint(equalTo: self.titleLabelView.topAnchor).isActive = true

        let leftPaddingConstraintForLogo = collectionView.frame.size.width - 100.0 - CGFloat(padding)
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftPaddingConstraintForLogo)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": self.logoPicture]))
    }
    
    //button actions
    @objc func callAction(){
        print("click")
        guard let url = URL(string: "telprompt://" + (Client.shared.item?.telefone)!) else{
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func servicesAction(){
        let servicesVC = ServicesViewController()
        present(servicesVC, animated: true, completion: nil)
    }
    
    @objc func locationAction(){
        let alert = UIAlertController(title: "Endereço", message: Client.shared.item?.endereco ?? "Rua dos Mockados, 41", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func commentsAction(){
        //default: header + main (2)
        if(self.collectionView.numberOfItems(inSection: 0) >= 2){
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
        }
    }
}

class BottomCell: UICollectionViewCell {
    var viewFrame : CGRect = CGRect()
    override init(frame: CGRect){
        super.init(frame: frame)
        viewFrame = frame
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let callButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "call_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let servicesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "services_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "location_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "comments_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let favoritesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favorites_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        //constraint setup for location icon on map label
        //FIXME: icon dimensions
        mapLabelLocationIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mapLabelLocationIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mapLabelLocationIcon.layer.cornerRadius = 25
        
        mapLabelLocationIcon.centerYAnchor.constraint(equalTo: mapLabelView.topAnchor).isActive = true
        mapLabelLocationIcon.leftAnchor.constraint(equalTo: favoritesLabel.leftAnchor).isActive = true
    
        //other views
        //addConstraints
        //...
        
        //constraint setup for cell structure (vertical padding)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": callButton, "v1": callLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": servicesButton, "v1": servicesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": locationButton, "v1": locationLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": commentsButton, "v1": commentsLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v3]-[v2]-[v4][v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": favoritesButton, "v1": favoritesLabel, "v2": textDescription, "v3": line1px, "v4": mapView, "v5": mapLabelView]))
        
        //button`s actions
        callButton.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        servicesButton.addTarget(self, action: #selector(servicesAction), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(commentsAction), for: .touchUpInside)
    }
    
    @objc func callAction(sender: UIButton!){
        NotificationCenter.default.post(name: Notification.Name("call"), object: nil)
    }
    
    @objc func servicesAction(){
        NotificationCenter.default.post(name: Notification.Name("services"), object: nil)
    }
    
    
    @objc func locationAction(){
        NotificationCenter.default.post(name: Notification.Name("location"), object: nil)
    }
    
    @objc func commentsAction(){
        NotificationCenter.default.post(name: Notification.Name("comments"), object: nil)
    }
}

class CommentCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.contentView.isUserInteractionEnabled = false
        self.backgroundColor = .blue
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userCommentPictureView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "favorite_button")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.titulo ?? "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.titulo ?? "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = Client.shared.item?.titulo ?? "Mock Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.text = "Nota: "
        label.text?.append(contentsOf: "5")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        return label
    }()
    
    let noteImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "favorite_button")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    func getIndexPathInt() -> Int? {
        guard let superView = self.superview as? UICollectionView else {
            print("superview is not a UICollectionView - getIndexPath")
            return nil
        }
        
        guard let index = superView.indexPath(for: self)?.item else{
            print("error while getting index")
            return nil
        }
        
        return index
    }
    
    func setupViews(){
        let padding = 16
        
        addSubview(userCommentPictureView)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(noteLabel)
        
        //constraint setup for user picture view
        userCommentPictureView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userCommentPictureView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userCommentPictureView.layer.cornerRadius = 40

        //userCommentPictureView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        userCommentPictureView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        //constraint setup for name label

        //constraint setup for cell (horizontal)
        let noteLabelSpacing = 8/*self.frame.size.width - userCommentPictureView.frame.size.width - nameLabel.frame.size.width - nameLabel.frame.size.width - 32*/
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-[v1]-\(noteLabelSpacing)-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": userCommentPictureView, "v1": nameLabel, "v2": noteLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-[v1]-\(noteLabelSpacing)-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": userCommentPictureView, "v1": titleLabel, "v2": noteLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-[v1]-\(noteLabelSpacing)-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": userCommentPictureView, "v1": commentLabel, "v2": noteLabel]))

        //constraint setup for note
        noteLabel.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true

        //constraint setup for cell (vertical)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": titleLabel, "v2": commentLabel]))
    }
}
