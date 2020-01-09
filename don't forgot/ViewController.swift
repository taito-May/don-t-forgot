//
//  addController.swift
//  don't forgot
//
//  Created by タイト on 2019/07/04.
//  Copyright © 2019 taito. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var percent: UILabel!
    var inmainlists : [inMaintodo] = []
    var listnumber = Int()
    var checkmarkpercent = 0
    var checkmarkcount = Int()
    var checkmarkcount100 = Int()
    var percentarray = [String]()
    var percentnumber = Int()
    var mainlist : [Maintodo] = []
    
    let savedata : UserDefaults = UserDefaults.standard
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inmainlists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MotimonoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MotimonoCell", for: indexPath)
        MotimonoCell.textLabel!.text = inmainlists[indexPath.row].list
        if inmainlists[indexPath.row].check == "check" {
            MotimonoCell.accessoryType = .checkmark
        percent.text = mainlist[listnumber].percent
        }
        
        return MotimonoCell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedData = UserDefaults.standard.object(forKey: "\(listnumber)List") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [inMaintodo] {
                inmainlists = unarchivedObject
            }
        }
        if let storedData = UserDefaults.standard.object(forKey: "listList") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Maintodo] {
                mainlist = unarchivedObject
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toaddController" {
            let nextVC = segue.destination as! addController
            nextVC.listnumber = self.listnumber
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MotimonoCell = tableView.cellForRow(at: indexPath)
        if inmainlists[indexPath.row].check == "none"{
            inmainlists[indexPath.row].check = "check"
        } else {
            inmainlists[indexPath.row].check = "none"
        }
        if inmainlists[indexPath.row].check == "check"{
            MotimonoCell?.accessoryType = .checkmark
        } else {
            MotimonoCell?.accessoryType = .none
        }
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: inmainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "\(listnumber)List")
        checkmarkcount = 0
        for i in 0 ..< inmainlists.count {
            if inmainlists[i].check == "check" {
                checkmarkcount += 1
                print(checkmarkcount)
            }
        }
        checkmarkcount100 = checkmarkcount*100
        checkmarkpercent = checkmarkcount100/inmainlists.count
        mainlist[listnumber].percent = "\(checkmarkpercent)%"
        let archivedData2 = try! NSKeyedArchiver.archivedData(withRootObject: mainlist, requiringSecureCoding: false)
        savedata.set(archivedData2, forKey: "listList")
        percent.text = mainlist[listnumber].percent
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let MotimonoCell = tableView.cellForRow(at: indexPath)
        if inmainlists[indexPath.row].check == "check" {
            inmainlists[indexPath.row].check = "none"
        } else {
            inmainlists[indexPath.row].check = "check"
        }
        if inmainlists[indexPath.row].check == "none" {
            MotimonoCell?.accessoryType = .none
        } else {
            MotimonoCell?.accessoryType = .checkmark
        }
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: inmainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "\(listnumber)List")
        checkmarkcount = 0
        for i in 0 ..< inmainlists.count {
            if inmainlists[i].check == "check" {
                checkmarkcount += 1
            }
        }
        checkmarkcount100 = checkmarkcount*100
        checkmarkpercent = checkmarkcount100/inmainlists.count
        mainlist[listnumber].percent = "\(checkmarkpercent)%"
        let archivedData2 = try! NSKeyedArchiver.archivedData(withRootObject: mainlist, requiringSecureCoding: false)
        savedata.set(archivedData2, forKey: "listList")
        percent.text = mainlist[listnumber].percent
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.tableView.setEditing(editing, animated: animated)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            inmainlists.remove(at: indexPath.row)
            tableView.reloadData()
            let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: inmainlists, requiringSecureCoding: false)
            savedata.set(archivedData, forKey: "\(listnumber)List")
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath){
        let moveData = inmainlists[indexPath.row]
        inmainlists.remove(at: indexPath.row)
        inmainlists.insert(moveData, at:destinationIndexPath.row)
        tableView.reloadData()
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: inmainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "\(listnumber)List")
    }
    @IBAction func toadd() {
        performSegue(withIdentifier: "toaddController", sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if let storedData = UserDefaults.standard.object(forKey: "\(listnumber)List") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [inMaintodo] {
                inmainlists = unarchivedObject
            }
        }
        if let storedData = UserDefaults.standard.object(forKey: "listList") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Maintodo] {
                mainlist = unarchivedObject
            }
        }
        tableView.reloadData()
        
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
