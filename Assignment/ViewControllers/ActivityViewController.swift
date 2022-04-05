//
//  ActivityViewController.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-30.
//

import UIKit

class ActivityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    // MARK: Data source
    var db = TouristActivityApp.shared

    // MARK: Outlets
    @IBOutlet weak var activityGridCollectionView: UICollectionView!
    
    // MARK: Actions
    
    // MARK: UICollectionViewDataSource Required Functions

    // 1. Set the number of items in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return db.getActivities().count
    }
    
    // 2. dequeueReusableCell with the given cell identifier from setupCollectionView method.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as! ActivityCollectionViewCell
        
        let currActivity:Activity = db.getActivities()[indexPath.row]
        
        // 3. populate the current cell with the required values
        cell.populateActivityCollectionCell(currentActivity: currActivity)
        
        return cell
    }
    
    // - Detecting clicks on the row
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You clicked on row #: \(indexPath.row)")
        
        loadActivityDetail(listRow: indexPath.row)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Required Functions
    
    // 1. First add the insetForSectionAt from UICollectionViewDelegateFlowLayout.
    func collectionView(_ collectionView: UICollectionView,
                     layout collectionViewLayout: UICollectionViewLayout,
                     insetForSectionAt section: Int) -> UIEdgeInsets {
        // 2. Add the inset for collection view sections. I added left and right space 8 because I need to match the minimum line spacing between the cells.
        return UIEdgeInsets(top: 2.0, left: 8.0, bottom: 2.0, right: 8.0)
    }

    // 3. Add to assign the size for the cell so added the method from UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 4. Get the assigned layout from the collection view.
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        
        // 5. Distribute the width of cells.
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        // 6. Return the size of each cell but make sure it should be less of line spacing.
        return CGSize(width: widthPerItem - 8, height: 250)
    }
    
    // MARK: Helper Functions
    private func setUpCollectionView() {
         // 1. Register a default cell for collection view
        activityGridCollectionView
                .register(UICollectionViewCell.self,
                 forCellWithReuseIdentifier: "cell")

         // 2.Set the delegate actions to the current view controller.
        activityGridCollectionView.delegate = self
        activityGridCollectionView.dataSource = self

         // 3. Create a custom flow layout for this.
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
        
         // 4. Set a minimum line spacing with your padding
         layout.minimumLineSpacing = 8
        
         // 5. Set the minimum interim-item spacing half of the line-spacing.
         layout.minimumInteritemSpacing = 4

         // 6. Set this custom layout to the collection view
        activityGridCollectionView
               .setCollectionViewLayout(layout, animated: true)
    }
    
    func loadActivityDetail(listRow: Int){
        // 1a. Programatically Navigating to Activity List Screen
        
        // -  Try to get a reference to the next screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "ActivityDetailScreen") as? ActivityDetailViewController else {
            print("Cannot find next screen")
            return
        }
        
        //values for next screen
        nextScreen.activityListIndex = listRow
        
        // 1b. Navigate to the next screen
        self.navigationController?.pushViewController(nextScreen, animated: true)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("User is logged In?: \(defaults.bool(forKey: "loggedInStatus"))")
        
        // 1. Check weather the remember me switch is on or not
        let isUserRemembered:Bool = UserDefaults.standard.bool(forKey: "isSwitchOn")
        // 2. Check weather the user is loggedIn or LoggedOut
        let isUserLoggedIn:Bool = UserDefaults.standard.bool(forKey: "loggedInStatus")
            
        print(#function,"isUserRemembered: \(isUserRemembered) isUserLoggedIn: \(isUserLoggedIn)")
            // if user is logged in before
        if (isUserLoggedIn && isUserRemembered) {
            print("------- Fetching user-specific purchased tickets from UserDefaults DB Before Loading the Tab controller-------")
            
            // 1b. Fetching user-specific purchased tickets from UserDefaults DB if there is any
            let fetchedPurchasedTicketsList: [Ticket] = db.getStoredPurchasedTicketsList()
            
            // 1c. Setting our local app reference for the PurchasedTicketList equal to the list fetched from the UserDefaults DB
            db.setpurchasedTicketList(updatedPurchasedTicketList: fetchedPurchasedTicketsList)
        }
        
        setUpCollectionView()
        
        // MARK: programattically adding a navigation bar button for Logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
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

extension Double {
    var priceFormat:String {
        return String(format:"%.2f", self)
    }
    var intFormat:String {
        return String(format:"%.0f", self)
    }
}

