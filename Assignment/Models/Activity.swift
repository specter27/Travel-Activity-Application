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
    private var activityDescription: String
    private var host: String
    private var pricePerPerson: Double
    private var photo: String
    private var tag: String
    private var webLink: String
    
    // -Default Intializer
    init(name: String, pricePerPerson: Double, photo: String, city: String, webLink: String, activityDescription: String, host: String){
        self.city = city
        self.name = name
        self.pricePerPerson = pricePerPerson
        self.photo = photo
        self.tag = "none"
        self.activityDescription = activityDescription
        self.host = host
        self.webLink = webLink
        
    }
    
    // - Convenience Intializer
    convenience init(name: String, pricePerPerson: Double, photo: String, city: String, tag: String, webLink: String,activityDescription: String, host: String){
        self.init(name: name, pricePerPerson: pricePerPerson, photo: photo, city: city, webLink: webLink, activityDescription: activityDescription, host: host)
        self.tag = tag
        
    }
    
    func getPhoto() -> String{
        return self.photo
    }
    func getCity() -> String{
        return self.city
    }
    func getWebLink() -> String{
        return self.webLink
    }
    func getName() -> String{
        return self.name
    }
    func getActivityDescription() -> String{
        return self.activityDescription
    }
    func getPrice() -> Double{
        return self.pricePerPerson
    }
    func getTags() -> String {
        return self.tag
    }
    func getHost() -> String{
        return self.host
    }
}
