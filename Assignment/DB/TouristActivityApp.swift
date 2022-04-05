//
//  TouristActivityApp.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-29.
//

import UIKit

// - This class provides a Singleton
class TouristActivityApp{
    
    static let shared = TouristActivityApp()
    private init() {}
    
    
    // MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    // MARK: Variables
    
    private var purchasedTicketList : [Ticket] = []
    //private let LoggedInUser
    
    private var userList : [User] = [
        User(email: "nirav@gmail.com", password: "1234"),
        User(email: "sheldon.cooper@email.com", password: "cooper"),
        User(email: "leonard.hofstadter@email.com", password: "bigbang")
    
    ]
    
    private var activityList : [Activity] = [
        Activity(name: "Telltale Ghost Tour", pricePerPerson: 26, photo: "activity1", city: "Prague", webLink: "https://www.airbnb.ca/experiences/381893?adults=1&location=Prague&currentTab=experience_tab&federatedSearchId=fa44efee-3506-4e68-b2a3-507fabe7b787&searchId=0474dcb7-0557-4a2d-97a8-1533a41f16b4&sectionId=5b0f37d0-f9cb-4226-b7fa-0aba93881d3c&source=p2",activityDescription: "We meet infront of the Old Town Hall, right next to the Astronomical Clock, embarking on a voyage to the lesser known underbelly of the historic Old Town of Prague.", host: "Max"),
        Activity(name: "Bohemian Switzerland Park", pricePerPerson: 100, photo: "activity3", city: "Prague", tag: "popular", webLink: "https://www.airbnb.ca/experiences/900725?adults=1&location=Prague%2C%20Czech%20Republic&currentTab=experience_tab&federatedSearchId=9890c40c-cf1b-4bd9-b706-6048e7aeddd9&searchId=&sectionId=4097fa68-da38-4810-a215-9ce76eac12e2&source=p2", activityDescription: "We will take a trip to the area of the Bohemian Switzerland national park. We will spend there about 8 hours and during this time I will show you the best spots.", host: "Marek Ohanka"),
        Activity(name: "Historic Tour with Drinks", pricePerPerson: 48, photo: "activity2", city: "Prague", webLink: "https://www.airbnb.ca/experiences/1648584?adults=1&location=Prague&currentTab=experience_tab&federatedSearchId=fa44efee-3506-4e68-b2a3-507fabe7b787&searchId=0474dcb7-0557-4a2d-97a8-1533a41f16b4&sectionId=5b0f37d0-f9cb-4226-b7fa-0aba93881d3c&source=p2", activityDescription: "Famous for musicians, artists and actors from all over the world, that have lived, worked and played in this majestic city.", host: "Linton"),
        
        Activity(name: "Hidden beer gems of Old Prague", pricePerPerson: 56, photo: "activity4", city: "Prague", webLink: "https://www.airbnb.ca/experiences/1270055?adults=1&location=Prague%2C%20Czech%20Republic&currentTab=experience_tab&federatedSearchId=9890c40c-cf1b-4bd9-b706-6048e7aeddd9&searchId=6d516cb8-ca16-4e84-98d1-8ccab2f89144&sectionId=edac6b31-5d8c-40e8-860c-1f5c166ee10a&source=p2", activityDescription: "This tour will take you through the historical streets of Old Prague. While walking to different beer venues we will also pass some of the most famous sights of Prague such as Old Town square.", host: "Lukáš"),
        Activity(name: "Prague View Points eBike tour", pricePerPerson: 85, photo: "activity5", city: "Prague", tag: "popular", webLink: "https://www.airbnb.ca/experiences/88942?adults=1&location=Prague&currentTab=experience_tab&federatedSearchId=fa44efee-3506-4e68-b2a3-507fabe7b787&searchId=0474dcb7-0557-4a2d-97a8-1533a41f16b4&sectionId=5b0f37d0-f9cb-4226-b7fa-0aba93881d3c&source=p2", activityDescription: "You will see 7 districts of Prague from 7 magical vantage points. These spots are unique not only for making pics, videos or Instagram. You will witness the 3 most important historical sites of Prague.", host: "Jan & Gary"),
        Activity(name: "Green Fairy: Absinthe Tour", pricePerPerson: 71, photo: "activity6", city: "Prague", webLink: "https://www.airbnb.ca/experiences/172500?adults=1&location=Prague&currentTab=experience_tab&federatedSearchId=fa44efee-3506-4e68-b2a3-507fabe7b787&searchId=0474dcb7-0557-4a2d-97a8-1533a41f16b4&sectionId=5b0f37d0-f9cb-4226-b7fa-0aba93881d3c&source=p2", activityDescription: "You’ll get to know the history of this drink, and experience different ways how to prepare and drink it. You can try it Czech and French way. And you’ll have a chance to find your favourite taste.", host: "Nataly")
       
    ]
    
    // MARK: Helper function (Abstraction)
    
    // setpurchasedTicketList(): This function will set the values purchasedTicketList
    func setpurchasedTicketList(updatedPurchasedTicketList: [Ticket]) {
        print("PurchasedTicketList value BEFORE= \(self.purchasedTicketList)")
        print("----------------- Setting PurchasedTicketList Intially -----------------")
        self.purchasedTicketList = updatedPurchasedTicketList
        print("PurchasedTicketList value AFTER= \(self.purchasedTicketList)")
    }
    
    // getpurchasedTicketList(): This function will return a copy of Latest purchasedTicketList
    func getpurchasedTicketList() -> [Ticket] {
        return self.purchasedTicketList
    }
    
    // addToPurchasedTickets(): This function will add the purchasedTicket to purchasedTicketList
    func addToPurchasedTickets(purchasedTicket: Ticket) {
        print("PurchasedTicketList value BEFORE= \(self.purchasedTicketList)")
        print("----------------- Adding Ticket in PurchasedTicketList -----------------")
        self.purchasedTicketList.append(purchasedTicket)
        print("PurchasedTicketList value AFTER= \(self.purchasedTicketList)")
    }
    
    // removeFromPurchasedTickets(): This function will remove the Ticket from passed index of purchasedTicketList
    func removeFromPurchasedTickets(index: Int) {
        print("----------------- Adding Ticket in PurchasedTicketList -----------------")
        print("------ Removing Ticket from PurchasedTicketList from index: \(index) ------")
        self.purchasedTicketList.remove(at: index)
        print("PurchasedTicketList value AFTER= \(self.purchasedTicketList)")
    }
    
    
    // getUserTicketCost(): This function will return the total cost of all the tickets in users purchasedTicketList
    func getUserTicketCost() -> Double {
        var result : Double = 0
        for ticket in self.purchasedTicketList {
            result = result + (ticket.pricePerPerson * ticket.quantity)
        }
        return result
    }
    
    // getStoredPurchasedTicketsList(): This function will Fetch user-specific purchased tickets from UserDefaults DB if there is any
    func getStoredPurchasedTicketsList() -> [Ticket]{
        
        let userName = self.defaults.string(forKey: "loggedInUser") ?? ""
        
        var fetchedPurchasedTicketsList: [Ticket] = []
        
        // check if we have key for storing user PurchasedTicketsList in the UserDefaults DB
        if(userName == ""){
            print("Unable to get the userKey for username=\(userName)")
            return fetchedPurchasedTicketsList
        }else{
            print("Got the UserKey for username=\(userName)\nGetting the StoredPurchasedTicketsList From UserDefaults DB")
        }
        
       
        
        let encodedFetchedPurchasedTicketsList: [Data] = defaults.object(forKey:"\(userName.lowercased())PurchasedTickets") as? [Data] ?? [Data]()
        
        if(encodedFetchedPurchasedTicketsList.count>0){
            for data in encodedFetchedPurchasedTicketsList{
                // - Attempt to convert the data back into a Ticket object
                let decoder = JSONDecoder()
                if let ticket = try? decoder.decode(Ticket.self, from: data) {
                    print(ticket)
                    fetchedPurchasedTicketsList.append(ticket)
                }
            }
        }
        
        print("fetchedPurchasedTicketsList for \(userName) List is \(fetchedPurchasedTicketsList)")
        
        return fetchedPurchasedTicketsList
        
    }
    
    // updatePurchasedTicketList(): This function will update the user specific purchasedTicketList in the UserDefaults DB
    func updatePurchasedTicketList(){
        let username = self.defaults.string(forKey: "loggedInUser") ?? ""
        let userTicketKey : String = "\(username.lowercased())PurchasedTickets"
        
        // check if we have key for storing user PurchasedTicketsList in the UserDefaults DB
        if(userTicketKey == "PurchasedTickets"){
            print("Unable to get the userTicketKey for username=\(username)")
            return
        }else{
            print("Got the UserTicketKey for username=\(username)\nUpdating the PurchasedTicketsList in UserDefaults DB with latest changes")
        }
        
        var encodedPurchasedTicketList:[Data] = []

        for ticket in purchasedTicketList{
            // convert the ticket data into a format that UserDefaults DB can understand
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(ticket) {
                // if conversion succeeded, then add the ticket in encodedPurchasedTicketList
                encodedPurchasedTicketList.append(encoded)
            } else {
                print("Sorry, could not save the Ticket for: \(ticket) in  encodedPurchasedTicketList")
            }
            
        }
        
        // - Adding the encodedPurchasedTicketList in the UserDefaults DB
        self.defaults.set(encodedPurchasedTicketList, forKey: "\(userTicketKey)")
        
            
        // Let user know the data was saved
        print(" ------------ PurchasedTicketList Updation in UserDefaults DB Complete! ------------")
        
    }
    
    func getUsers() -> [User] {
        return userList
    }
    
    func getActivities() -> [Activity] {
        return activityList
        
    }
    
    

}
