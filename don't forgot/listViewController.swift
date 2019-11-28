//
//  listViewController.swift
//  don't forgot
//
//  Created by タイト on 2019/08/24.
//  Copyright © 2019 taito. All rights reserved.
//

import UIKit

class listViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var listtableView: UITableView!
    var listnumber = Int()
    var percentarray = [String]()
    let savedata : UserDefaults = UserDefaults.standard
    var mainlists : [Maintodo] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let title = listCell.contentView.viewWithTag(1) as! UILabel
        title.text = "\(mainlists[indexPath.row].title)"
        let percent = listCell.contentView.viewWithTag(2) as! UILabel
        percent.text = "\(percentarray[indexPath.row])"
        
        return listCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainlists.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if savedata.object(forKey: "listList") != nil {
            mainlists = savedata.object(forKey: "listList") as! [Maintodo]
        }
        if savedata.object(forKey: "percent") != nil {
            percentarray = savedata.object(forKey: "percent") as! [String]
        }
        listtableView.dataSource = self
        listtableView.delegate = self
        
        listtableView.allowsMultipleSelection = true
        
        listtableView.tableFooterView = UIView(frame: .zero)
        
        self.view.addSubview(listtableView)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if savedata.object(forKey: "listList") != nil {
            mainlists = savedata.object(forKey: "listList") as! [Maintodo]
        }
        if savedata.object(forKey: "percent") != nil {
            percentarray = savedata.object(forKey: "percent") as! [String]
            
        }
        listtableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listnumber = mainlists[indexPath.row].listnumber
        performSegue(withIdentifier: "toViewController", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            let nextVC = segue.destination as! ViewController
            nextVC.listnumber = self.listnumber
            
        }
    }
        
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.listtableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mainlists.remove(at: indexPath.row)
            tableView.reloadData()
            savedata.set(mainlists, forKey: "listList")
            savedata.set(percentarray, forKey: "percent")
        }
        
    }
    func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath){
        let moveData1 = tableView.cellForRow(at: indexPath as IndexPath)
        mainlists.remove(at: indexPath.row)
        mainlists.insert(moveData1, at:destinationIndexPath.row)
        savedata.set(mainlists, forKey: "listList")
        savedata.set(percentarray, forKey: "percent")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
