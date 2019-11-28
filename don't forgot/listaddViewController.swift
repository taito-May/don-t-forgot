//
//  listaddViewController.swift
//  don't forgot
//
//  Created by タイト on 2019/08/24.
//  Copyright © 2019 taito. All rights reserved.
//

import UIKit

class listaddViewController: UIViewController {
    var percentarray = [String]()
    let savedata : UserDefaults = UserDefaults.standard
    var listnumbernumber : Int = 0
    var mainlists : [Maintodo] = []
    @IBOutlet weak var listTextField: UITextField!
    
    
    @IBAction func listaddButton(_ sender: Any) {
        let mainlist = Maintodo(title: listTextField.text!, percent: "0%", listnumber: listnumbernumber)
        listTextField.text = ""
        listnumbernumber += 1
        mainlists.append(mainlist)
        savedata.set(mainlists, forKey: "listList")
        savedata.set(percentarray, forKey: "percent")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if savedata.object(forKey: "listList") != nil {
            mainlists = savedata.object(forKey: "listList") as! [Maintodo] 
        }
        if savedata.object(forKey: "percent") != nil {
            percentarray = savedata.object(forKey: "percent") as! [String]
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Do any additional setup after loading the view.
    }        // Do any additional setup after loading the view.
}
    

   
