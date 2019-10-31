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
    
    var listKomet = [String]()
    
    let savedata : UserDefaults = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        listCell.textLabel!.text = listKomet[indexPath.row]
        return listCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listKomet.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if savedata.object(forKey: "listList") != nil {
            listKomet = savedata.object(forKey: "listList") as! [String]
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
            listKomet = savedata.object(forKey: "listList") as! [String]
        }
        listtableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listnumber = indexPath.row
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
            listKomet.remove(at: indexPath.row)
            tableView.reloadData()
            savedata.set(listKomet, forKey: "listList")
        }
        
    }
    func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath){
        let moveData = tableView.cellForRow(at: indexPath as IndexPath)?.textLabel!.text
        listKomet.remove(at: indexPath.row)
        listKomet.insert(moveData!, at:destinationIndexPath.row)
        savedata.set(listKomet, forKey: "listList")
    }
    
}
