//
//  Google.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/18/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class Google {
    
    
    class func getGeoCoder(cordinate: CLLocationCoordinate2D, completion: @escaping ((AddressDM)?) -> Void) {
        let lat = cordinate.latitude
        let long = cordinate.longitude
        print(lat,444,long)
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&key=\(Constant.map_key)"
        
       
        
        
        
    }
}
