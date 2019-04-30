//
//  ViewController.swift
//  QueroTransformar
//
//  Created by João Pedro Coutinho on 30/04/2019.
//  Copyright © 2019 João Pedro Coutinho. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var listSize : Int = 10
    var listContent : Array<Any> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Tela Inicial"
        //FIXME: mock function call (reminder)
        listContent = getListContent()
        tableView.register(ListCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSize
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIFont.systemFont(ofSize: 24).pointSize*2
    }
    
    func getListContent() -> Array<Any>{
        return Array()
    }
}

class ListCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented yet")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mock Item"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
}
