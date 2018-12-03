//
//  MapViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/21/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Map"
        mapView.delegate = self
        
        mapView.addAnnotations(CharityDataProvider.charities)
        
        let r = MKCoordinateRegion(center: CharityDataProvider.charities.first!.coordinate,
                           latitudinalMeters: 20000,
                           longitudinalMeters: 20000)
        mapView.setRegion(r, animated: false)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let point = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "hey")
        point.canShowCallout = true
        return point
    }

}
