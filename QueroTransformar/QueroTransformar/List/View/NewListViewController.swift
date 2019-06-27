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
        
        //title setup
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
//        let navItem = UINavigationItem()
//
//        navItem.title = "Tela Inicial"
//        navBar.items = [navItem]
//        navBar.backgroundColor = UIColor.clear
//        navBar.prefersLargeTitles = true
//
//        self.view.addSubview(navBar)
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Tela Inicial"
        
        
        //ws to get list content
        getListContent()
        showLoadingView()
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
        //return listSize
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let servicesViewController = ServicesViewController()
        
        //get content info
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListViewCell
        
        //FIXME: when error occurs, will donwload first known item
        showLoadingView()
        Client.shared.getItem(id: Client.shared.itemList[indexPath.item] as! String){
            success in
            
            if(!success){
                //couldn`t donwload list
                let alert = UIAlertController(title: "Oops!", message: "Algo deu errado ao tentar realizar o download do item :(", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else{
                //download ok
                //collection view layout setup
                let flowLayout = UICollectionViewFlowLayout()
                let mainViewController = MainViewController(collectionViewLayout: flowLayout)
                
                tableView.deselectRow(at: indexPath, animated: true)
                
                //presenting on main thread
                DispatchQueue.main.async {
                    self.present(mainViewController, animated: true)
                }
            }
            
            //ui update on main thread
            DispatchQueue.main.async {
                self.loadingView.isHidden = true
                self.container.isHidden = true
                self.loadingController.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListViewCell
        //cell.setText(text: Client.shared.itemList[indexPath.item] as! String)
        return cell
    }
    
}


//class ListCell: UITableViewCell {
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Mock Item"
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    //adds subviews + constraints setup
//    func setupViews(){
//        addSubview(nameLabel)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
//    }
//}
