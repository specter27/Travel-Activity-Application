//
//  TouristActivityApp.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-29.
//

class TouristActivityApp{
    
    var userList : [User] = []
    var activityList : [Activity] = []
    
    init(){
        intializeUserList()
        intializeActivitiesList()
    }
    
    
    func intializeUserList() {
        userList.append(User(email: "sheldon.cooper@email.com", password: "cooper"))
        userList.append(User(email: "leonard.hofstadter", password: "hofstader"))
        
    }
    
    func intializeActivitiesList() {
        activityList.append(Activity(name: "Intro to Pottery wheel", pricePerPerson: 29, photo: "pottery", city: "Toronto"))
        
    }
}
