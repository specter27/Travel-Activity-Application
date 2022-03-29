//
//  Activity.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-29.
//

import Foundation

class Activity{
    
    // -Stored Properties
    private var city: String
    private var name: String
    private var pricePerPerson: Double
    private var photo: String
    
    // -Default Intializer
    init(name: String, pricePerPerson: Double, photo: String, city: String){
        self.city = city
        self.name = name
        self.pricePerPerson = pricePerPerson
        self.photo = photo
        
    }
}
