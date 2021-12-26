//
//  SideBarVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 9/7/21.
//

import UIKit

class SideBarVC: UIViewController {
    
    @IBOutlet weak var myTtripsBtn: HighlightButton!{
        didSet {
            myTtripsBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var paymentTypeBtn: HighlightButton!{
        didSet {
            paymentTypeBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
        
    @IBOutlet weak var favoriteAddressesBtn: HighlightButton!{
        didSet {
            favoriteAddressesBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    @IBOutlet weak var conView: UIView! {
        didSet {
            conView.layer.cornerRadius = 20
            conView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var lblName: UILabel! {
        didSet {
            lblName.font = UIFont.init(name: "Lato-Bold", size: 18)
        }
    }
    
    @IBOutlet weak var lblPhoneNum: UILabel! {
        didSet {
            lblPhoneNum.font = UIFont.init(name: "Lato-Medium", size: 14)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.4338467832)
        conView.transform = .init(translationX: -conView.frame.width, y: 0)
        dismissBtn.alpha = 0
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        UIView.animate(withDuration: 0.3) {
            self.conView.transform = .identity
            self.dismissBtn.alpha = 1
        }
    }
    
    @IBAction func myTripsBtnPressed(_ sender: Any) {
        let vc = TripHistoryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    @IBAction func dismisBtnPressd(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.conView.transform = .init(translationX: -self.conView.frame.width, y: 0)
            self.dismissBtn.alpha = 0
        }completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
   
}



