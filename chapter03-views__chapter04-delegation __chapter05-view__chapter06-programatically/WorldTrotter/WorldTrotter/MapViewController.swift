//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Christopher Lee on 11/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var pinIndex: Int = 0
    var annotationList: [MKPointAnnotation]!
    
    override func loadView() {
        //3 Pins
        let p1 = MKPointAnnotation()
        p1.title = "Malaysia"
        p1.coordinate = CLLocationCoordinate2D(latitude: 4.2105, longitude: 101.9758)
        let p2 = MKPointAnnotation()
        p2.title = "Melbourne"
        p2.coordinate = CLLocationCoordinate2D(latitude: 37.8136, longitude: 144.9631)
        let p3 = MKPointAnnotation()
        p3.title = "Auckland"
        p3.coordinate = CLLocationCoordinate2D(latitude: -36.8485, longitude: 174.7633)
        annotationList = [p1, p2, p3]
        
        // Create map view
        mapView = MKMapView()
        mapView.delegate = self
        
        // Set it as the view of this controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
     
        // Setting up constraint anchors
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // Silver Challenge
        initLocalizationButton(segmentedControl)
        
        // Gold Challenge
        initRandomLocationButton(segmentedControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    // Silver Challenge
    func initLocalizationButton(_ anyView: UIView!){
        let localizationButton = UIButton.init(type: .system)
        localizationButton.setTitle("Localization", for: .normal)
        localizationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(localizationButton)
        
        //Constraints
        let topConstraint = localizationButton.topAnchor.constraint(equalTo:anyView.topAnchor, constant: 32 )
        let leadingConstraint = localizationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = localizationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchUpInside)
    }
    
    @objc func showLocalization(sender: UIButton!){
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //This is a method from MKMapViewDelegate, fires up when the user`s location changes
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
    }
    
    // Gold Challenge
    func initRandomLocationButton(_ anyView: UIView!) {
        let randomLocationButton = UIButton.init(type: .system)
        randomLocationButton.setTitle("Pin Location", for: .normal)
        randomLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(randomLocationButton)
        
        
        // Constraints
        let topRandomLocationButtonConstraint = randomLocationButton.topAnchor.constraint(equalTo: anyView.topAnchor, constant: 60)
        let leadingRandomLocationButtonConstraint = randomLocationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingRandomLocationButtonConstraint = randomLocationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        topRandomLocationButtonConstraint.isActive = true
        leadingRandomLocationButtonConstraint.isActive = true
        trailingRandomLocationButtonConstraint.isActive = true
        
        randomLocationButton.addTarget(self, action: #selector(getRandomLocation(_:)), for: .touchUpInside)
    }
    
    @objc func getRandomLocation(_ sender: UIButton) {
        let region = MKCoordinateRegionMakeWithDistance(annotationList[pinIndex].coordinate, 700, 700)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotationList[pinIndex])
        pinIndex += 1
        pinIndex = pinIndex % 3
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "") as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotationList[pinIndex], reuseIdentifier: "")
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = MKPinAnnotationView.purplePinColor()
        } else {
            pinView?.annotation = annotationList[pinIndex]
        }
        return pinView
    }
}
