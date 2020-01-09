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
    let savedata : UserDefaults = UserDefaults.standard
    var mainlists : [Maintodo] = []
    var percentnumber = Int()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let title = listCell.contentView.viewWithTag(1) as! UILabel
        title.text = mainlists[indexPath.row].title
        let percent = listCell.contentView.viewWithTag(2) as! UILabel
        percent.text = mainlists[indexPath.row].percent
        
        return listCell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainlists.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedData = UserDefaults.standard.object(forKey: "listList") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Maintodo] {
                mainlists = unarchivedObject
            }
        }
        listtableView.dataSource = self
        listtableView.delegate = self
        
        listtableView.allowsMultipleSelection = true
        
        listtableView.tableFooterView = UIView(frame: .zero)
        
        self.view.addSubview(listtableView)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let storedData = UserDefaults.standard.object(forKey: "listList") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Maintodo] {
                mainlists = unarchivedObject
            }
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
            let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: mainlists, requiringSecureCoding: false)
            savedata.set(archivedData, forKey: "listList")
        }
        
    }
    func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath){
        let moveData1 = mainlists[indexPath.row]
        mainlists.remove(at: indexPath.row)
        mainlists.insert(moveData1, at:destinationIndexPath.row)
        tableView.reloadData()
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: mainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "listList")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
