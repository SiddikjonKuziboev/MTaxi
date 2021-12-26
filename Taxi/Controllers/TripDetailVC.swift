//
//  TripDetailVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/19/21.
//

import UIKit
import GoogleMaps

class TripDetailVC: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var tripDetailChild: TripDetailChildVC!
    
    var isHeaveChild : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTripDetailChildVC()
        tripDetailChild.moveView(state: .partial)
        
        drawRoute()
        mapView.delegate = self

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

//Draw route
extension TripDetailVC {
    
    func drawRoute() {
        
        let startLatitude = 41.29265317153452
        let startLongitude = 69.27962154150009

        let endLatitude = 41.309915239036215
        let endLongitude = 69.28073231130838
        
        
        let data: [LocationDM] = [
        LocationDM(lon: 69.27962154150009 , lat: 41.29265317153452, course: 0),
        LocationDM(lon: 69.27367139607668, lat: 41.29830274868191, course: 0),
        LocationDM(lon: 69.27314803004265, lat: 41.29874455783209, course: 0),
        LocationDM(lon: 69.27775774151087, lat: 41.30177945895141, course: 0),
        LocationDM(lon: 69.28410116583109, lat: 41.30666638814692, course: 0),
        LocationDM(lon: 69.28073231130838, lat: 41.309915239036215, course: 0)
        ]
     
        
        self.mapView.animate(toLocation: CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude))
        self.mapView.animate(toZoom: 14)
//        mapView.animate(toViewingAngle: 50)
        
        
        
        let path = GMSMutablePath()
        
        for i in data {
            path.add(CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon))
        }
        let polyline = GMSPolyline(path: path)
        
        polyline.strokeColor = UIColor.blue
        polyline.strokeWidth = 3.0
        polyline.map = mapView
        
        setPlaceMark(imageName: "blue_point", coordinate: CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude), isClear: false)
        
        setPlaceMark(imageName: "red_point", coordinate: CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude), isClear: false)
        
        
        
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
