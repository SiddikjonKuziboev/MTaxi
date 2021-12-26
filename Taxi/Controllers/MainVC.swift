//
//  MainVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/17/21.
//

import UIKit
import GoogleMaps

class MainVC: UIViewController {
    
    
    @IBOutlet weak var sideMenuBtn: UIButton!{
        didSet {
            sideMenuBtn.layer.masksToBounds = false
            sideMenuBtn.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.10059675), radius: 10, opacity: 1)
            sideMenuBtn.layer.borderWidth = 1.5
            sideMenuBtn.layer.borderColor =  #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
            
        }
    }
    
    @IBOutlet weak var startLocationAddressBtn: UIButton! {
        didSet {
            startLocationAddressBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var endLocationAddressBtn: UIButton!{
        didSet {
            endLocationAddressBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 14)
        }
    }
    
    @IBOutlet weak var bottomContainerView: UIView!{
        didSet {
            bottomContainerView.addShadow(offset: CGSize(width: -15, height: -8), color: #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 0.06), radius: 10, opacity: 1)
            
            bottomContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomContainerView.layer.cornerRadius = 14
        }
    }
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var pin: UIImageView!
    
    let manager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        getUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
   
    @IBAction func currentLocationBtnPressed(_ sender: Any) {
        getUserLocation()
    }
    
    
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
        let vc = SideBarVC(nibName: "SideBarVC", bundle: nil)
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: false, completion: nil)
    }
    
    @IBAction func startLocationAddressBtnPressed(_ sender: Any) {
    }
    
    @IBAction func endLocationAddressBtnPressed(_ sender: Any) {
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    
}


//MARK: Get user location
extension MainVC {
    
    func getUserLocation() {

        manager.getUserCurrentLocation(fromVC: self) {[self] location in
            self.mapView.animate(toLocation: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon))
            self.mapView.animate(toZoom: 15)
            mapView.animate(toViewingAngle: 22)

        }
    }
    
}


extension MainVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let str = lines.first
            self.startLocationAddressBtn.setTitle(str, for: .normal)
        }
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.startLocationAddressBtn.setTitle("checking...", for: .normal)
        
    }
    
}

