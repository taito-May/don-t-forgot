//
//  todoclass.swift
//  don't forgot
//
//  Created by タイト on 2019/11/28.
//  Copyright © 2019 taito. All rights reserved.
//

import Foundation

class Maintodo : NSObject {
    var title : String?
    var percent : String?
    var listnumber : Int!
    
    init(title: String, percent: String,listnumber: Int){
        self.title = title
        self.percent = percent
        self.listnumber = listnumber
    }
}


