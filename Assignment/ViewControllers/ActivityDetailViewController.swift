//
//  ActivityDetailViewController.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-04-01.
//

import UIKit

class ActivityDetailViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    //MARK: Variables
    var numberOfTickets:Double = 1
    
    // MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    // MARK: Data source
    var db = TouristActivityApp.shared
    let numberOfTicketsList:[String] = ["1","2","3","4","5"]
    
    
    //MARK: Data From Previous Screen
    var activityListIndex: Int = -1
    
    // MARK: Outlets
    @IBOutlet weak var lblActivityName: UILabel!
    @IBOutlet weak var imgActivityPhoto: UIImageView!
    @IBOutlet weak var lblactivityDescription: UILabel!
    @IBOutlet weak var lblHost: UILabel!
    @IBOutlet weak var lblpricePerPerson: UILabel!
    @IBOutlet weak var pickerTickets: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: Helper Functions
    func purchaseTicket(purchasedTicket: Ticket){
        
        // Step 1: Add the purchasedTicket in the local app data source array(purchasedTicketList)
        db.addToPurchasedTickets(purchasedTicket: purchasedTicket)
        // Step 2: Updating the latest changes in PurchasedTicketsList in the UserDefaults DB
        db.updatePurchasedTicketList()
    }
    
    func totalCost(pricePerPerson:Double, quantity:Double) -> Double{
        return (pricePerPerson * quantity)
    }
    

    
    // MARK: Lifecycle Functions
    // -------------------- Execution order: #1 --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Activity Detail Screen Loaded")
        
        //picker view
        self.pickerTickets.delegate = self
        self.pickerTickets.dataSource = self
        
        //date picker minimum date
        var dayComponent = DateComponents()
        dayComponent.day = 1
        let theCalendar = Calendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
        datePicker.minimumDate =  nextDate
        
        //get activity
        let activity = db.getActivities()[activityListIndex]
        
        
        //set activity details on screen
        lblActivityName.text = "\(activity.getName())"
        imgActivityPhoto.image = UIImage(named:"\(activity.getPhoto())")
        lblactivityDescription.text = "\(activity.getActivityDescription())"
        lblHost.text = "\(activity.getHost())"
        lblpricePerPerson.text = "$\(activity.getPrice().priceFormat)"
        
        //Navigation bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        

    }
    @objc func logoutTapped() {
        // 1. Removeing the required Key-Value Pairs from the UserDefaults DB
        
        // 1a. Removeing Remember Me Switch Status from the UserDefaults DB
        self.defaults.removeObject(forKey:"isSwitchOn")
        
        // 1b. Removing the loggedInStatus(Key-pair value) in the UserDefaults DB
        self.defaults.removeObject(forKey:"loggedInStatus")
        
        // 1c. Removing the loggedInUser(Key-pair value) in the UserDefaults DB
        self.defaults.removeObject(forKey: "loggedInUser")
        
        // after user has successfully logged out
         
        //MARK: Switching the root view for resolving issue for using tab & navigation controller together
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    
    //MARK: Action functions
    @IBAction func btnVisitWebsite(_ sender: Any) {
        let activity = db.getActivities()[activityListIndex]
        //Get a reference to the next screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "webViewScreen") as? WebsiteWebViewViewController else {
            print("Cannot find next screen")
            return
        }
        nextScreen.webUrl = activity.getWebLink()
        
        //Navigate to the next screen
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @IBAction func btnPurchaseTicket(_ sender: Any) {
        //get number of tickets
        print("Number of selected tickets are: \(numberOfTickets)")
        //get selected date with format
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let selectedDate = formatter.string(from: datePicker.date)
        print(selectedDate)
        
        //Adding Tickets to user's purchase list
        let activity = db.getActivities()[activityListIndex]
        let ticket = Ticket(activityName: activity.getName(), pricePerPerson: activity.getPrice(), photo: activity.getPhoto(), quantity: numberOfTickets, visitDate: selectedDate)
        
        purchaseTicket(purchasedTicket: ticket)
        
        //alert box to show total cost
        let alertBox = UIAlertController(title: "Ticket Details", message: "The total cost of the purchase: $\(totalCost(pricePerPerson: activity.getPrice(), quantity: numberOfTickets).priceFormat )", preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertBox, animated: true)
    }
    
    //Picker View Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numberOfTicketsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.numberOfTicketsList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfTickets = Double(self.numberOfTicketsList[row]) ?? 0
    }
}
