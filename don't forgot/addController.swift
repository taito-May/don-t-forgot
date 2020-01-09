//
//  addController.swift
//  don't forgot
//
//  Created by タイト on 2019/07/04.
//  Copyright © 2019 taito. All rights reserved.
//

import UIKit



class addController: UIViewController {
    var listnumber = Int()
    let ListViewController = listViewController()
    var MotimonoKomet = [String]()
    var checkmarkArray = [String]()
    var inmainlists : [inMaintodo] = []
    let savedata : UserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var MotimonoTextField: UITextField!
    
    
    @IBAction func MotimonoaddButton(_ sender: Any) {
        inmainlists.append(inMaintodo.init(list: MotimonoTextField.text!, check: "none", listnumber: listnumber))
         let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: inmainlists, requiringSecureCoding: false)
        savedata.set(archivedData, forKey: "\(listnumber)List")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedData = UserDefaults.standard.object(forKey: "\(listnumber)List") as? Data {
            if let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData) as? [inMaintodo] {
                inmainlists = unarchivedObject
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
