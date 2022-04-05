//
//  ViewController.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-29.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    // MARK: Variables
    // 1 -> Email does not exist
    // 2 -> Password Does not Match
    var userAuthorizationStatus : Int = 0
    
    // MARK: Data source
    var db = TouristActivityApp.shared

    // MARK: Outlets
    @IBOutlet weak var loginScreenImg: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    
    @IBOutlet weak var errorLabel: UILabel!
    // MARK: Actions
    @IBAction func rememberMeSwitched(_ sender: Any) {
        
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        print("Login Pressed")
        
        // 1a. Validating the userEmail
        guard let email = userEmail.text, email.isEmpty == false, email.isValidEmail else{
            let errorMsg = "Provide a valid email.\nHINT: Please ensure that email field is not empty"
            self.errorLabel.text = errorMsg
            print("\(errorMsg)")
            return
        }
        
        // 1b. Validating the userPassword
        guard let password = userPassword.text, password.isEmpty == false else{
            let errorMsg = "Provide a valid password.\nHINT: Please ensure that password field is not empty"
            self.errorLabel.text = errorMsg
            print("\(errorMsg)")
            return
        }
        
        
        
        // 2. Checking User Authorization Status
        if(checkAuthorization(email: email, password: password)){
            
            //MARK: Switching the root view for resolving issue for using tab & navigation controller together
            
            // after login is done, maybe put this in the login web service completion block
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            
            
            // 3. Checking Remember Me Switch Status
            if(rememberMe.isOn){
                // 3a. Add Remember Me Switch Status to the UserDefaults
                self.defaults.set(true, forKey:"isSwitchOn")
               
            }
            // 4. Setting(Save) the required user deatils in UserDefaults DB
            
            // 4a. Add Credentials to the UserDefaults
            self.defaults.set(password, forKey:email)
            // 4b. Setting the loggedInStatus to the UserDefaults
            self.defaults.set(true, forKey: "loggedInStatus")
            // 4c. setting the entered user as the loggedInUser
            self.defaults.set(email, forKey: "loggedInUser")
            // 4d. Add Remember Me Switch Status to the UserDefaults
            //self.defaults.set(false, forKey:"isSwitchOn")
            
            // 4. Programatically Navigating to Activity List Screen
            navigateNextScreen(userName: email)
            
        } else{
            // -Update the error label for different cases
            
            switch(userAuthorizationStatus){
                 
                case 1:
                   self.errorLabel.text = "Email doesn't exist!"
                case 2:
                   self.errorLabel.text = "Password Does not Match !!"
                default:
                   self.errorLabel.text = "Invalid Credentials!"
            }
            
            // 5a. Clearing the email field
            self.userEmail.text = ""

            // 5b. Clearing the password field
            self.userPassword.text = ""
        }
        
    }
    
    // MARK: Helper Functions
    func checkAuthorization(email: String, password: String) -> Bool{
        var authorizationStatus : Bool = false
        for user in db.getUsers(){
            if(user.getEmail() == email.lowercased()){
                if(user.getPassword() == password){
                    authorizationStatus = true
                    break
                } else{
                    self.userAuthorizationStatus = 2
                }
            } else{
                self.userAuthorizationStatus = 1
            }
        }
        return authorizationStatus
    
    }
    
    func navigateNextScreen(userName: String){
        
        // 1a. Programatically Navigating to Activity List Screen
        
        // -  Try to get a reference to the next screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "ActivityScreen") as? ActivityViewController else {
            print("Cannot find next screen")
            return
        }
        
        print("------- Fetching user-specific purchased tickets from UserDefaults DB -------")
        
        // 1b. Fetching user-specific purchased tickets from UserDefaults DB if there is any
        let fetchedPurchasedTicketsList: [Ticket] = db.getStoredPurchasedTicketsList()
        
        // 1c. Setting our local app reference for the PurchasedTicketList equal to the list fetched from the UserDefaults DB
        db.setpurchasedTicketList(updatedPurchasedTicketList: fetchedPurchasedTicketsList)
        
        // 1d. Navigate to the next screen
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    
    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("------- Executing LoginViewController viewDidLoad() function -------")
        
        // - Setting the Remember Me Switch Status as per its Stored rememberMe Status in UserDefaults DB
        self.rememberMe.isOn = self.defaults.bool(forKey: "isSwitchOn")
        
        // - Print the Valid User Credential list
        print(db.getUsers())
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loginScreenImg.image = UIImage(named:"Login")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // -Resetting the error label
        self.errorLabel.text = ""
        
        // 1a. Clearing the email field
        self.userEmail.text = ""

        // 1b. Clearing the password field
        self.userPassword.text = ""
    }
    


}

