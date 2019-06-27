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
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "MainViewHeader", bundle: nil), forCellReuseIdentifier: "headerCellId")
            tableView.register(UINib(nibName: "MainViewCenter", bundle: nil), forCellReuseIdentifier: "centerCellId")
            tableView.register(UINib(nibName: "MainViewComment", bundle: nil), forCellReuseIdentifier: "commentCellId")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Tela Principal"
    }
    
}

extension NewMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return listSize
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(indexPath.item == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "headerCellId", for: indexPath) as! MainViewHeader
        } else if(indexPath.item == 1){
            cell = tableView.dequeueReusableCell(withIdentifier: "centerCellId", for: indexPath) as! MainViewCenter
        } else if(indexPath.item >= 2){
            cell = tableView.dequeueReusableCell(withIdentifier: "commentCellId", for: indexPath) as! MainViewComment
        }

        return cell
    }
    
}
