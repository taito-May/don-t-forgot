//
//  listaddViewController.swift
//  don't forgot
//
//  Created by タイト on 2019/08/24.
//  Copyright © 2019 taito. All rights reserved.
//

import UIKit

class listaddViewController: UIViewController {
    let savedata : UserDefaults = UserDefaults.standard
    var listnumbernumber : Int = 0
    var mainlists : [Maintodo] = []
    @IBOutlet weak var listTextField: UITextField!
    
    
    @IBAction func listaddButton(_ sender: Any) {
        mainlists.append(Maintodo.init(title: listTextField.text!, percent: "0%", inMaintodolist: [], listnumber: listnumbernumber))
        listnumbernumber += 1
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: mainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "listList")
        savedata.set(listnumbernumber, forKey: "listnumbernumbernumber")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedData = UserDefaults.standard.object(forKey: "listList") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [Maintodo] {
                mainlists = unarchivedObject
            }
        }
            if savedata.object(forKey: "listnumbernumbernumber") != nil {
            listnumbernumber = savedata.object(forKey: "listnumbernumbernumber") as! Int
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Do any additional setup after loading the view.
    }        // Do any additional setup after loading the view.
}
    

   
