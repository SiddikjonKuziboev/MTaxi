//
//  TripHistoryTVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/19/21.
//

import UIKit

class TripHistoryTVC: UITableViewCell {
    
    static let identifier = "TripHistoryTVC"
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
            containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var lblStartAddress: UILabel!{
        didSet  {
            lblStartAddress.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    
    @IBOutlet weak var lblEndAddress: UILabel!{
        didSet  {
            lblEndAddress.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var lblDate: UILabel!{
        didSet  {
            lblDate.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var carImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}
