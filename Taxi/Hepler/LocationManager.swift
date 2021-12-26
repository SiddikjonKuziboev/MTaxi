//
//  LocationManager.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/17/21.
//

import UIKit
import CoreLocation

public typealias LM = LocationManager

public class LocationManager: NSObject {
    
    
    private var presentedVC: UIViewController!
    
    private var locationManager: CLLocationManager!
        
    private var locationCallBack: ((_ location: LocationDM)->Void)?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.pausesLocationUpdatesAutomatically = false

    }
    
    
    
    func getUserCurrentLocation(fromVC: UIViewController, completion: @escaping (_ location: LocationDM)->Void) {
        self.presentedVC = fromVC
        self.locationCallBack = completion
        startUpdatingUserLocation()
    }
    
    func updateUserCurrentLocation() {
        startUpdatingUserLocation()
    }
    
    func stopUpdatingUserCurrentLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    private func startUpdatingUserLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                openSettingsAlert()
            default:
                print("AUTHORIZATION DENIER \(status.self)")
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    
    private func openSettingsAlert() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        presentedVC.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let userLocation = locations.first else {return}
        
        let currentLoc = LocationDM.init(lon: userLocation.coordinate.longitude, lat: userLocation.coordinate.latitude, course: userLocation.course)
        locationCallBack?(currentLoc)
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        locationManager.stopUpdatingLocation()
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}
