//
//  ViewController.swift
//  TwitterLikeButton
//
//  Created by 刘剑文 on 16/3/21.
//  Copyright © 2016年 kevinil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var showTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.tableFooterView = UIView(frame: CGRectZero)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ShowCell
        return cell
    }
    
    

}

