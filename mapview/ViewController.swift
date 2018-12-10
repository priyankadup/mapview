//
//  ViewController.swift
//  mapview
//
//  Created by Student 06 on 01/01/01.
//  Copyright © 2001 Student 06. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate{
    fileprivate let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //startDetecting()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func LocationDetectButton(_ sender: UIButton) {
        startDetecting()
    }
    func startDetecting()
{
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    //NSLocationWhenINUseUsageDescription
    
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var latitude:CGFloat , longitude:CGFloat
        let current_location: CLLocation = locations.last!
        
        
            latitude = CGFloat(current_location.coordinate.latitude)
            longitude = CGFloat(current_location.coordinate.longitude)
            print("latitude = \(latitude) and longitude = \(longitude)")
        manager.startUpdatingLocation()
        let coOrdinate : CLLocationCoordinate2D = current_location.coordinate
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: coOrdinate, span: span)
        mapview.setRegion(region, animated: true)
       
        let annotation = MKPointAnnotation()
        annotation.coordinate = coOrdinate
        mapview.addAnnotation(annotation)
       
       let geo = CLGeocoder()
        //let location:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        geo.reverseGeocodeLocation(current_location) { (placemarks, error) in
            
            let placemark:CLPlacemark = placemarks!.first!
                let info = "Country = \(placemark.country!)"
            annotation.title = info
            }
        }
        
        
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

