//
//  inMaintodoclass.swift
//  don't forgot
//
//  Created by タイト on 2019/12/05.
//  Copyright © 2019 taito. All rights reserved.
//

import Foundation

class inMaintodo : NSObject ,NSCoding {
    var list : String!
    var check : String!
    var listnumber : Int!
    
    init (list: String, check: String, listnumber: Int){
        self.list = list
        self.check = check
        self.listnumber = listnumber
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.list, forKey: "list")
        aCoder.encode(self.check, forKey: "check")
        aCoder.encode(self.listnumber, forKey: "listnumber")
    }
    required init?(coder aDecoder: NSCoder) {
        list = aDecoder.decodeObject(forKey: "list") as? String
        check = aDecoder.decodeObject(forKey: "check") as? String
        listnumber = aDecoder.decodeObject(forKey: "listnumber") as? Int
    }
}
