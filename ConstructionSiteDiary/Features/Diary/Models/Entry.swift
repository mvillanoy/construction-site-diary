//
//  Entry.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import Foundation

class Entry {
    var date: String?
    var lat: Double?
    var long: Double?
    var area: String?
    var category: String?
    var tags:String?
    var event:String?
    var comment:String?
    var task:String?
    
    var dictionary: [String: Any] {
           return ["date": date ?? "",
                   "lat": lat ?? 0,
                   "long": long ?? 0,
                   "area": area ?? "",
                   "tags": tags ?? "",
                   "event": event ?? "",
                   "comment": comment ?? "",
                   "task": task ?? "",
           ]
       }
}

