//
//  PurchasedTicketsViewController.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-31.
//

import UIKit

class PurchasedTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    // MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    // MARK: Data source
    var db = TouristActivityApp.shared
    
    // MARK: Outlets
    @IBOutlet weak var purchasedTicketsTableView: UITableView!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    // ------------------------------------
    // MARK: Mandatory table view functions
    // ------------------------------------
    
    // 1. Set the number of items in the table view.
    
    // - Define the total number of rows you want to display in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.getpurchasedTicketList().count
    }
    
    // 2. dequeueReusableCell with the given cell identifier from setupCollectionView method.
    
    // Controls the DATA that is display in each row of the tableview
    // This function is called once per row in the tableview
    // It will draw the data you want to display in the corresponding row   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = purchasedTicketsTableView.dequeueReusableCell(withIdentifier: "ticketCell", for:indexPath) as! TicketTableViewCell
        let currTicket:Ticket = db.getpurchasedTicketList()[indexPath.row]
        // 3. Populate the current cell with the required values
        cell.populateTicketTableViewCell(currentTicket: currTicket)

        return cell
    }
    
    
    // MARK: Deleting a row (with swipe action)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Deletion of purchased ticket is a 4 step process
            
            // Step 1: Delete the ticket from the local app data source array(purchasedTicketList)
            db.removeFromPurchasedTickets(index: indexPath.row)
            
            // Step 2: Updating the latest changes in PurchasedTicketsList in the UserDefaults DB
            db.updatePurchasedTicketList()

            // Step 3: Delete the row from the UI
            self.purchasedTicketsTableView.deleteRows(at: [indexPath], with: .fade)
            
            //  Step 4: Update the totalCostLabel
            updateCostLabel()
        }
    }
    
    // MARK: Helper Functions
    
    // updateCostLabel(): This function will update the cost label as per the purchasedTicketList
    func updateCostLabel(){
        
        if db.getpurchasedTicketList().isEmpty {
            
            // 1. Hidding the table view if there is no purchasedTickets for the user
            self.purchasedTicketsTableView.isHidden = true
            
            // TODO: 2. Removing the table view programatically from the UI of View
             self.purchasedTicketsTableView.sectionHeaderHeight = 0
            
            // 3. Update the totalCostLabel
            self.totalCostLabel.text = "No Puchased Tickets\nGo purchase the tickets"
        } else {
            purchasedTicketsTableView.reloadData()
            self.purchasedTicketsTableView.isHidden = false
            //  Update the totalCostLabel
            self.totalCostLabel.text = "Total (CAD): $\(db.getUserTicketCost().priceFormat)"
        }
        
    }
    
    @objc func logoutTapped(){
        
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
    

    
    // MARK: Lifecycle Functions
    // -------------------- Execution order: #1 --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        purchasedTicketsTableView.delegate = self
        purchasedTicketsTableView.dataSource = self
        
        // Programatically setting the row height in the table view
        purchasedTicketsTableView.rowHeight = 200
        
        // MARK: programattically adding a navigation bar button for Logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    }
    
    
    
    // -------------------- Execution order: #2 --------------------
    override func viewWillAppear(_ animated: Bool) {
        updateCostLabel()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
