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
    let savedata : UserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var MotimonoTextField: UITextField!
    
    
    @IBAction func MotimonoaddButton(_ sender: Any) {
        MotimonoKomet.append(MotimonoTextField.text!)
        MotimonoTextField.text = ""
        checkmarkArray.append("none")
        savedata.set(MotimonoKomet, forKey: "\(listnumber)List")
        savedata.set(checkmarkArray, forKey: "\(listnumber)array")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if savedata.object(forKey: "\(listnumber)List") != nil {
            MotimonoKomet = savedata.object(forKey: "\(listnumber)List") as! [String]
        }
        if savedata.object(forKey: "\(listnumber)List") != nil {
            checkmarkArray = savedata.object(forKey: "\(listnumber)array") as! [String]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
