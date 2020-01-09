//
//  todoclass.swift
//  don't forgot
//
//  Created by タイト on 2019/11/28.
//  Copyright © 2019 taito. All rights reserved.
//

import Foundation

class Maintodo : NSObject ,NSCoding{
    var title : String!
    var percent : String!
    var inMaintodolist : [inMaintodo] = []
    var listnumber : Int!
    
    init(title: String, percent: String, inMaintodolist: [inMaintodo],listnumber: Int){
        self.title = title
        self.percent = percent
        self.inMaintodolist = inMaintodolist
        self.listnumber = listnumber
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.percent, forKey: "percent")
        aCoder.encode(self.inMaintodolist, forKey: "inMaintodolist")
        aCoder.encode(self.listnumber, forKey: "listnumber")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as? String
        percent = aDecoder.decodeObject(forKey: "percent") as? String
        inMaintodolist = aDecoder.decodeObject(forKey: "inMaintodolist") as! [inMaintodo]
        listnumber = aDecoder.decodeObject(forKey: "listnumber") as? Int
    }
}


