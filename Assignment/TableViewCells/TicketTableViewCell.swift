//
//  TicketTableViewCell.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-31.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    
    // MARK: Outlets

    @IBOutlet weak var activityImage: UIImageView!
    
    @IBOutlet weak var activityNameLabel: UILabel!
    
    @IBOutlet weak var priceDetailLabel: UILabel!
    @IBOutlet weak var visitDateLabel: UILabel!
    
    @IBOutlet weak var ticketTotalCostLabel: UILabel!
    
    // MARK: Helper function
    // 1. Setting the values of the UI elements inside the custom Table View Cell
    func populateTicketTableViewCell(currentTicket: Ticket){
        
        // Setting values of the UI elements inside the custom row or cell
        activityImage.image = UIImage(named: currentTicket.photo)
        
        activityNameLabel.text = currentTicket.activityName
        priceDetailLabel.text = "$\(currentTicket.pricePerPerson.priceFormat) X \(currentTicket.quantity.intFormat) adult: $\((currentTicket.pricePerPerson*currentTicket.quantity).priceFormat)"
        visitDateLabel.text = currentTicket.visitDate
        ticketTotalCostLabel.text = "Total (CAD)  $\((currentTicket.pricePerPerson*currentTicket.quantity).priceFormat)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
