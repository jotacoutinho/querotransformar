//
//  MainViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 06/05/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let topCellId = "topCellId"
    let bottomCellId = "bottomCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.lightGray

        collectionView.register(TopCell.self, forCellWithReuseIdentifier: "topCellId")
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: "bottomCellId")
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
    }
}

class BottomCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
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
        button.backgroundColor = .red
        return button
    }()
    
    let servicesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "services_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    let locationButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "location_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    let commentsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "comments_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    let favoritesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favorites_button"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    let callLabel : UILabel = {
        let label = UILabel()
        label.text = "Ligar"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let servicesLabel : UILabel = {
        let label = UILabel()
        label.text = "Serviços"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Endereço"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "Comentários"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoritesLabel : UILabel = {
        let label = UILabel()
        label.text = "Favoritos"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //adds subviews + constraints setup
    func setupViews(){
        
        let padding = 16
        
        let buttonsStack : UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let labelsStack : UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        //adding views
        addSubview(buttonsStack)
        addSubview(labelsStack)
        
        //adding buttons to stack
        buttonsStack.addSubview(callButton)
        buttonsStack.addSubview(servicesButton)
        buttonsStack.addSubview(locationButton)
        buttonsStack.addSubview(commentsButton)
        buttonsStack.addSubview(favoritesButton)
        
        //adding labels to stack
        labelsStack.addSubview(callLabel)
        labelsStack.addSubview(servicesLabel)
        labelsStack.addSubview(locationLabel)
        labelsStack.addSubview(commentsLabel)
        labelsStack.addSubview(favoritesLabel)
        
        //constraint setup for buttons
        //FIXME: 50px is the image size for 1x
        //TODO: fix "?? 50" to imageAppropriateSize, where imageAppropriateSize == image.size (based on device)
        let buttonSize = callButton.currentImage?.size.width ?? CGFloat(integerLiteral: 50)
        let buttonSpacing = (self.frame.size.width - (5 * buttonSize) - CGFloat(2 * padding)) / 4
        
        buttonsStack.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-\(buttonSpacing)-[v1]-\(buttonSpacing)-[v2]-\(buttonSpacing)-[v3]-\(buttonSpacing)-[v4]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":callButton, "v1":servicesButton, "v2":locationButton, "v3":commentsButton, "v4":favoritesButton]))
    
        //constraint setup for labels
        callLabel.centerXAnchor.constraint(equalTo: callButton.centerXAnchor).isActive = true
        servicesLabel.centerXAnchor.constraint(equalTo: servicesButton.centerXAnchor).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor).isActive = true
        commentsLabel.centerXAnchor.constraint(equalTo: commentsButton.centerXAnchor).isActive = true
        favoritesLabel.centerXAnchor.constraint(equalTo: favoritesButton.centerXAnchor).isActive = true
        
        //constraint setup buttons x labels (vertical padding)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": callButton, "v1": callLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": servicesButton, "v1": servicesLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": locationButton, "v1": locationLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": commentsButton, "v1": commentsLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": favoritesButton, "v1": favoritesLabel]))

        //constraint setup for cell
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": buttonsStack]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[v0]-\(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": labelsStack]))
        
        //other views
        //addConstraints
        //...
    }
    
    
}

class TopCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        //setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
