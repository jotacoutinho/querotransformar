//
//  NewMainViewController.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 27/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation
import UIKit

class NewMainViewController: UIViewController {
    //spinning view
    let loadingController = UIActivityIndicatorView()
    let loadingView = UIView()
    let container = UIView()
    
    var navBar = UINavigationBar()
    
    let viewModel = MainViewModel()
    var id = String()
    var listSize = Int()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 300
            tableView.register(UINib(nibName: "MainViewHeader", bundle: nil), forCellReuseIdentifier: "headerCellId")
            tableView.register(UINib(nibName: "MainViewCenter", bundle: nil), forCellReuseIdentifier: "centerCellId")
            tableView.register(UINib(nibName: "MainViewComment", bundle: nil), forCellReuseIdentifier: "commentCellId")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 203.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        
        viewModel.delegate = self
        loadItem(id: id)
        
    }
    
    func configureNavBar(){
        
        //title setup (image + text)
        let titleView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = viewModel.item?.cidade ?? "City"
        titleLabel.text?.append(" - ")
        titleLabel.text?.append(viewModel.item?.bairro ?? "Neigborhood")
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
        
        //constraints
        //self.navigationController?.navigationItem.titleView?.centerXAnchor.constraint(equalTo: (self.navigationController?.navigationBar.centerXAnchor)!).isActive = true
        //self.navigationController?.navigationItem.titleView?.centerYAnchor.constraint(equalTo: (self.navigationController?.navigationBar.centerYAnchor)!).isActive = true
        
        //self.navigationController?.navigationBar.backItem?.backBarButtonItem?.image = UIImage(named: "back_button")
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.red
        self.navigationController?.navigationItem.titleView?.addSubview(titleView)
    }
    
    func loadItem(id: String){
        showLoadingView()
        viewModel.loadItem(id: id)
    }
    
    //spinning view for loading
    func showLoadingView(){
        self.container.frame = self.view.frame
        self.container.center = self.view.center
        self.container.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.loadingView.center = self.view.center
        self.loadingView.backgroundColor = UIColor(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 0.7)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        self.loadingController.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.loadingController.center = CGPoint(x: loadingView.frame.size.width / 2,
                                                y: loadingView.frame.size.height / 2)
        
        self.loadingController.hidesWhenStopped = true
        self.loadingController.style =
            UIActivityIndicatorView.Style.whiteLarge
        
        self.loadingView.addSubview(self.loadingController)
        self.container.addSubview(self.loadingView)
        self.view.addSubview(self.container)
        
        self.loadingView.isHidden = false
        self.container.isHidden = false
        
        self.loadingController.startAnimating()
    }
    
    func stopLoadingView(){
        self.loadingView.isHidden = true
        self.container.isHidden = true
        self.loadingController.stopAnimating()
    }
    
    @objc func pressedBackButton(){
        self.dismiss(animated: true)
    }
    
    
    
    
    
    
}

extension NewMainViewController: MainViewModelDelegate{
    func didFinishLoadingContent(success: Bool) {
        if(success){
            //reload
            tableView.reloadData()
        } else{
            //show error dialog
        }
        stopLoadingView()
        configureNavBar()
    }
}

extension NewMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //setting up number of rows
        if let comments = viewModel.item?.comentarios.count{
            self.listSize = comments == 0 ? 2 : comments + 2
        } else{
            //header and center views
            self.listSize = 2
        }
        
        return self.listSize
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let item = viewModel.item{
            if(indexPath.item == 0){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellId", for: indexPath) as? MainViewHeader else{
                    return UITableViewCell()
                }
                cell.configure(for: item)
            } else if(indexPath.item == 1){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "centerCellId", for: indexPath) as? MainViewCenter else{
                    return UITableViewCell()
                }
                cell.configure(for: item, withDelegate: self)
            } else if(indexPath.item >= 2){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCellId", for: indexPath) as? MainViewComment else{
                    return UITableViewCell()
                }
                cell.configure(for: item.comentarios[indexPath.item - 2])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.item == 0){
            return 300
        } else if(indexPath.item == 1){
            return 396
        } else if(indexPath.item >= 2){
            return 140
        }
        
        return 140
    }
    
}

extension NewMainViewController: MainViewCenterDelegate{
    func makeCall() {
        guard let url = URL(string: "telprompt://" + (viewModel.item?.telefone)!) else{
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func presentServices() {
        let viewController = UIStoryboard(name: "ServicesView", bundle: nil).instantiateViewController(withIdentifier: "NewServicesViewController") 
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAddress() {
        let alert = UIAlertController(title: "Endereço", message: viewModel.item?.endereco ?? "Rua dos Mockados, 41", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func scrollToCommentSection() {
        let indexPath = IndexPath(row: 2 , section: 0)
        if(tableView.numberOfRows(inSection: 0) > 2){
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
    }
    
    
}
