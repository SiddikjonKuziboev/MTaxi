//
//  MainVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/17/21.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire
import SwiftyJSON

class MainVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var pin: UIImageView!
    
    @IBOutlet weak var sideMenuBtn: UIButton!{
        didSet {
            sideMenuBtn.layer.masksToBounds = false
            sideMenuBtn.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.10059675), radius: 10, opacity: 1)
            sideMenuBtn.layer.borderWidth = 1.5
            sideMenuBtn.layer.borderColor =  #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
            
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
    
    @IBOutlet weak var startLocationAddressBtn: UIButton!
    
    @IBOutlet weak var endLocationAddressBtn: UIButton!
    
    
    let manager = LocationManager()
    
    var userCurrentLocation: LocationDM! {
        didSet {
            guard let loc = userCurrentLocation else {
                return
            }
            setPlaceMark(imageName: "blue_point", coordinate: CLLocationCoordinate2D(latitude: loc.lat, longitude: loc.lon), isClear: false)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        drawRoute()
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



extension MainVC {
    
    //MARK: Get user location
    func getUserLocation() {
        manager.getUserCurrentLocation(fromVC: self) {[self] location in
            
            self.mapView.animate(toLocation: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon))
            //            self.userCurrentLocation = location
            self.mapView.animate(toZoom: 15)
            mapView.animate(toViewingAngle: 22)
            
        }
    }
    
    //MARK: PlaceMark
    func setPlaceMark(imageName: String, coordinate: CLLocationCoordinate2D?, isClear: Bool ) {
        if isClear {
            mapView.clear()
        }
        guard let coordinate = coordinate else {return}
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.icon = UIImage(named: imageName)
        marker.map = mapView
    }
}


extension MainVC: GMSMapViewDelegate {
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
        print(333,position.target)
        
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

//Draw route
extension MainVC {
    
    func drawRoute() {
        
        let startLatitude = 41.295849318447004
        let startLongitude = 69.26367681473494
        
        let endLatitude = 41.299554869344675
        let endLongitude = 69.27837934345007
        
        let b = "\(startLatitude),\(startLongitude)"
        let e = "\(endLatitude),\(endLongitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(b)&destination=\(e)&key=AIzaSyDUDLDmbFMrTxpVErn7H0GHrpF9TZXamas"

        
        
            setPlaceMark(imageName: "blue_point", coordinate: CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude), isClear: false)
            setPlaceMark(imageName: "red_point", coordinate: CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude), isClear: false)
            
            let camera = GMSCameraPosition(latitude: startLongitude, longitude: startLatitude, zoom: 10)
            mapView.animate(to: camera)
            
            
            let path = GMSMutablePath()
            //Change coordinates
            path.add(CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude))
            path.add(CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude))
            //            path.add(CLLocationCoordinate2D(latitude: -33.73, longitude: 151.41))
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.blue
            polyline.strokeWidth = 3.0
            polyline.map = mapView
            
        
    }
    
}
