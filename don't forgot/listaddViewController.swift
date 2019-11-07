//
//  listaddViewController.swift
//  don't forgot
//
//  Created by タイト on 2019/08/24.
//  Copyright © 2019 taito. All rights reserved.
//

import UIKit

class listaddViewController: UIViewController {
    var listKomet = [String]()
    var percentarray = [String]()
    let savedata : UserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var listTextField: UITextField!
    
    
    @IBAction func listaddButton(_ sender: Any) {
        listKomet.append(listTextField.text!)
        percentarray.append("0")
        listTextField.text = ""
        savedata.set(listKomet, forKey: "listList")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if savedata.object(forKey: "listList") != nil {
            listKomet = savedata.object(forKey: "listList") as! [String]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Do any additional setup after loading the view.
    }        // Do any additional setup after loading the view.
}
    

   
