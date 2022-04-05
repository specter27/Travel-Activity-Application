//
//  User.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-29.
//

import Foundation
class User{
    
    // - Stored Properties
    private var email: String
    private var password: String
    
    // - Default Intializer
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String{
        return self.email
    }
    
    func getPassword() -> String{
        return self.password
    }
}
extension User: CustomStringConvertible{
    var description: String{
        return "\nUserName: \(self.getEmail())\nPassword: \(self.getPassword()) "
    }
}
extension String {
   var isValidEmail: Bool {
      let regexForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let email = NSPredicate(format:"SELF MATCHES %@", regexForEmail)
      return email.evaluate(with: self)
   }
}
