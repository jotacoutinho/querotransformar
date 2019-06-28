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
    
    let viewModel = MainViewModel()
    var id = String()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: "MainViewHeader", bundle: nil), forCellReuseIdentifier: "headerCellId")
            tableView.register(UINib(nibName: "MainViewCenter", bundle: nil), forCellReuseIdentifier: "centerCellId")
            tableView.register(UINib(nibName: "MainViewComment", bundle: nil), forCellReuseIdentifier: "commentCellId")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Tela Principal"
        
        viewModel.delegate = self
        
        loadItem(id: id)
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
    }
}

extension NewMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return listSize
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
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
                cell.configure(for: item)
            } else if(indexPath.item >= 2){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCellId", for: indexPath) as? MainViewComment else{
                    return UITableViewCell()
                }
                cell.configure(for: item)
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
