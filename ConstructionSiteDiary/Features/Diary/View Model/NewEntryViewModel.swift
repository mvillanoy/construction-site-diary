//
//  NewEntryViewModel.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import Foundation
import UIKit


class NewEntryViewModel {
    var images: [UIImage] = []
    var entry = Entry()
    
    
    func submit(){
        APIManager.shared().upload(type: EndpointItem.addEntry, params: entry.dictionary, images: images) { (values, error) in
            print(values ?? "No data")
        }
    }
    
}
