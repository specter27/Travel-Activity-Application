//
//  Ticket.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-31.
//

class Ticket: Codable{
    
    // -Stored Properties
    var activityName: String
    var pricePerPerson: Double
    var photo: String
    var quantity: Double
    var visitDate: String
    
    // - Default Intializer
    init(activityName: String, pricePerPerson: Double, photo: String, quantity: Double, visitDate: String){
        self.activityName = activityName
        self.pricePerPerson = pricePerPerson
        self.photo = photo
        self.quantity = quantity
        self.visitDate = visitDate
    }

    
}
extension Ticket: CustomStringConvertible{
    var description: String{
        return "Ticket for: \(self.activityName)"
    }
}
