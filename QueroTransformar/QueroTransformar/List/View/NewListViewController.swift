//
//  NewListViewController.swift
//  QueroTransformar
//
//  Created by João Pedro De Souza Coutinho on 26/06/19.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import Foundation
import UIKit

class NewListViewController: UIViewController {
    var listSize : Int = 0
    var listContent : Array<Any> = Array()
    static let mainVC = MainViewController()
    
    //spinning view
    let loadingController = UIActivityIndicatorView()
    let loadingView = UIView()
    let container = UIView()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Tela Inicial"
           
        //ws to get list content
        //getListContent()
        //showLoadingView()
    }
    
    func getListContent(){
        Client.shared.getList(){
            success in
            if(!success){
                //couldn`t donwload list
                let alert = UIAlertController(title: "Oops!", message: "Algo deu errado ao tentar realizar o download da lista :(", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else{
                //download ok
                self.listSize = Client.shared.itemList.count
                //self.tableView.reloadData()
            }
            //ui update on main thread
            DispatchQueue.main.async {
                self.loadingView.isHidden = true
                self.container.isHidden = true
                self.loadingController.stopAnimating()
                //self.tableView.reloadData()
            }
        }
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
}

extension NewListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController:UIViewController = UIStoryboard(name: "MainView", bundle: nil).instantiateViewController(withIdentifier: "NewMainViewController") as UIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
                    
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListViewCell
        return cell
    }
    
}
