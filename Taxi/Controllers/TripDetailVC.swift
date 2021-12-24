//
//  TripDetailVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/19/21.
//

import UIKit
import GoogleMaps

class TripDetailVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var tripDetailChild: TripDetailChildVC!

    var isHeaveChild : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTripDetailChildVC()
        tripDetailChild.moveView(state: .partial)

    }
    

    override func viewWillAppear(_ animated: Bool) {
       

        navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: -  TripDetailChildVC -
extension TripDetailVC: TripDetailChildVCDelegate {
    
    func arrowBtnPressed() {
        isHeaveChild = !isHeaveChild
        self.tripDetailChild.arrowBtn.setImage(UIImage(named: !isHeaveChild ? "up_arrow" : "down_arrow"), for: .normal)
        tripDetailChild.moveView(state: isHeaveChild ? .full : .partial)
    }
    
        private func addTripDetailChildVC() {
            // Add Child View Controller
            tripDetailChild = TripDetailChildVC(nibName: "TripDetailChildVC", bundle: nil)
            tripDetailChild.delegate = self
            
            let backButton : UIButton = {
                let b = UIButton()
                b.backgroundColor = .white
                b.translatesAutoresizingMaskIntoConstraints = false
                return b
            }()
            
            tripDetailChild.viewSwiped = {[self] isFullySwiped in
                self.isHeaveChild = isFullySwiped
                
                self.view.insertSubview(backButton, belowSubview: tripDetailChild.view)
                self.tripDetailChild.arrowBtn.setImage(UIImage(named: !isFullySwiped ? "up_arrow" : "down_arrow"), for: .normal)

                
                if isHeaveChild {
                    
                    tripDetailChild.scrollView.isScrollEnabled = true
                    backButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                    backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                    backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                    backButton.tag = 100
                    UIView.animate(withDuration: 0.2) {
                        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                    }
                    
                    
                }else{
                    
                    //yarimtaki ochilgan bo'lsa
                    tripDetailChild.scrollView.isScrollEnabled = false
                    if let viewWithTag = self.view.viewWithTag(100) {
                        viewWithTag.removeFromSuperview()
                    }
                    UIView.animate(withDuration: 0.4) {
                        backButton.backgroundColor = UIColor.black.withAlphaComponent(0)
                    }
                    self.isHeaveChild = false
                }
                
            }
            tripDetailChild.view.transform = .init(translationX: 0, y: self.view.frame.height)
            tripDetailChild.modalPresentationStyle = .currentContext
            self.addChild(tripDetailChild)
            self.view.addSubview(tripDetailChild.view)
            
            tripDetailChild.didMove(toParent: self)
            let h = self.view.frame.height
            let w = self.view.frame.width
            tripDetailChild.view.frame = CGRect(x: 0, y: view.frame.maxY, width: w, height: h)
        }
        
      

    
}
