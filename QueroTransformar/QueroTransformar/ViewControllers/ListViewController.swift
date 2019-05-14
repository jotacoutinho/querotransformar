//
//  ViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 30/04/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    var listSize : Int = 0
    var listContent : Array<Any> = Array()
    
    //spinning view
    let loadingController = UIActivityIndicatorView()
    let loadingView = UIView()
    let container = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title setup
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tela Inicial"
        
        //ws to get list content (with an idle loading view)
        getListContent()
        showLoadingView()
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSize
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let servicesViewController = ServicesViewController()
        
        //get content info
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListCell
        //FIXME: when error occurs, will donwload first known item
        Client.shared.getItem(id: Client.shared.itemList[indexPath.item] as! String)
        
        //collection view layout setup
//        let flowLayout = UICollectionViewFlowLayout()
//        let mainViewController = MainViewController(collectionViewLayout: flowLayout)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        present(mainViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListCell
        cell.nameLabel.text = Client.shared.itemList[indexPath.item] as! String
        return cell
    }
    
    //row height setup
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIFont.systemFont(ofSize: 24).pointSize*2
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
                //FIXME
                self.listSize = 4
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

class ListCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mock Item"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //adds subviews + constraints setup
    func setupViews(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
}
