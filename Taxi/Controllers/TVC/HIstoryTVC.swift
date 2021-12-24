//
//  HIstoryTVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/19/21.
//

import UIKit

class HIstoryTVC: UITableViewCell {
    
    static let identifier = "HIstoryTVC"
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
            containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var lblStartAddress: UILabel!
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var lblEndAddress: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
