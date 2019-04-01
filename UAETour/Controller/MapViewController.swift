//
//  MapViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/30/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var appleMap: MKMapView!
    var lat : Double = 0
    var lon : Double = 0
    var tit : String = ""
    @IBOutlet weak var titleNav: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNav.title = tit
        appleMap.delegate = self
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        setupCordinate(coordinate: location, title: tit)
    }
    
    func mapView(_ appleMap: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var anoView : MKAnnotationView?
        if let pinView = appleMap.dequeueReusableAnnotationView(withIdentifier: "whitepinid") {
            anoView = pinView
            anoView?.annotation = annotation
        } else {
            anoView = MKAnnotationView(annotation: annotation, reuseIdentifier: "whitepinid")
            anoView?.image = UIImage(named: "whitepin")
            anoView?.canShowCallout = true
            
        }
        return anoView
    }
    
    //show annotation title without click it.
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if let annotation = view.annotation, let title = annotation.title {
                print("displaying:\(title!)")
                mapView.selectAnnotation( annotation, animated: true )
            }
        }
    }
    
    func setupCordinate(coordinate : CLLocationCoordinate2D, title : String){
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = coordinate
        dropPin.title = title
        appleMap.addAnnotation(dropPin)
        //mapView(appleMap, viewFor: dropPin)
        //can also define array of annotation use appleMap.addAnnotations([MKAnnotation])
        //appleMap.addAnnotation(dropPin)
        setupZoomLevel(loc: coordinate)
        //localSearchApi()
    
    }
    
    func setupZoomLevel(loc : CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.22, longitudeDelta: 0.22)
        //let region1 = MKCoordinateRegion(makeRect(coordinates: loc))
        let region = MKCoordinateRegion(center: loc, span: span)
        appleMap.setRegion(region, animated: true)
    }
    
    @IBAction func backBtnClick(_ sender: UIBarButtonItem){
            dismiss(animated: true, completion: nil)
    }

}
