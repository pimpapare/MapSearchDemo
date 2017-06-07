//
//  BaseTableViewController.swift
//  BaseUI
//
//  Created by pimpaporn chaichompoo on 3/1/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var rowHeight:CGFloat = 120.0

    var items = [String]()
    var tableView_custom:UITableView = UITableView()
    var TableViewCell:UITableViewCell = UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initTableView(item:[String],tableViewCustom:UITableView,tableViewName:String){
        
        items = item
        tableView_custom = tableViewCustom
        
        tableView_custom.delegate = self
        tableView_custom.dataSource = self
        tableView_custom.separatorColor = UIColor.clear
        tableView_custom.register(UINib(nibName:tableViewName, bundle: nil), forCellReuseIdentifier: .cell)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: .cell, for: indexPath as IndexPath)
        cell.textLabel?.text = items[0] as String
        return cell
    }    
}
