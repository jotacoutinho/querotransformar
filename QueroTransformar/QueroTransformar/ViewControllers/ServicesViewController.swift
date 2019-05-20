//
//  ServicesViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 30/04/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    let servicesLabel : UILabel = {
        let label = UILabel()
        label.text = "Serviços"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view setup
        navigationController?.navigationItem.titleView?.isHidden = true
        view.backgroundColor = .white
        setupViews()
        
        //servicesLabel action setup
        servicesLabel.isUserInteractionEnabled = true
        servicesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.servicesLabelAction)))
    }
    
    //adds subviews + constraints setup
    func setupViews(){
        //adding views
        view.addSubview(servicesLabel)
        
        //centralizing servicesLabel
        servicesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        servicesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //other views
        //addConstraints
        //...
    }
    
    //returns to main screen (development purpose only)
    @objc func servicesLabelAction(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
}
