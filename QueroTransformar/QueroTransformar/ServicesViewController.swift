//
//  ServicesViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 30/04/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadView()
        
        navigationController?.navigationItem.titleView?.isHidden = true
        view.backgroundColor = .white
    }
    
    override func loadView() {
        self.view = ServicesMainView(frame: UIScreen.main.bounds)
    }
}

class ServicesMainView: UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let servicesLabel : UILabel = {
        let label = UILabel()
        label.text = "Serviços"
        label.translatesAutoresizingMaskIntoConstraints = false
        //servicesLabel.center = view.center
        return label
    }()
    
    func setupViews(){
        addSubview(servicesLabel)
    }
}
