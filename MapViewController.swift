//
//  MapViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 04/07/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var point1 = MKPointAnnotation()
        var point2 = MKPointAnnotation()
        var point3 = MKPointAnnotation()
        
        point1.coordinate = CLLocationCoordinate2D(latitude: 19.058999, longitude: -98.232317)
        point1.title = "La Suprema Salsa"
        point1.subtitle = "Matriz Recta 431-30-18"
        mapa.addAnnotation(point1)
        
        point2.coordinate = CLLocationCoordinate2D(latitude: 19.0512033, longitude: -98.2836334)
        point2.title = "La Suprema Salsa"
        point2.subtitle = "UDLA"
        mapa.addAnnotation(point2)
        
        point3.coordinate = CLLocationCoordinate2D(latitude: 19.0131345, longitude: -98.2583948)
        point3.title = "La Suprema Salsa"
        point3.subtitle = "Via Atlixcayolt 283-80-86"
        mapa.addAnnotation(point3)
        
        //Universidad Madero
        var UMAD = CLLocationCoordinate2D(latitude: 19.047292, longitude: -98.258518)

        mapa.centerCoordinate = UMAD
        mapa.delegate = self
        
        //Span of the map
        mapa.setRegion(MKCoordinateRegionMake(point1.coordinate, MKCoordinateSpanMake(0.07,0.07)), animated: true)
        
        var directionsRequest = MKDirectionsRequest()
        let suprema1 = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
        let suprema2 = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
        let suprema3 = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point3.coordinate.latitude, point3.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.setSource(MKMapItem(placemark: suprema1))
        directionsRequest.setSource(MKMapItem(placemark: suprema2))
        directionsRequest.setSource(MKMapItem(placemark: suprema3))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
