//
//  Maps.swift
//  uicollectionview
//
//  Created by Tushar Tapadia on 22/07/20.
//  Copyright © 2020 Tushar Tapadia. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit



class Maps: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

        let mapkitView: MKMapView = {
            let map = MKMapView()
            map.mapType = MKMapType.standard
            map.isRotateEnabled = true
            map.isPitchEnabled = true
            map.isZoomEnabled = true
            map.isScrollEnabled = true
            map.showsPointsOfInterest = true
            map.showsBuildings = true
            return map
        }()

    var locationManager = CLLocationManager()
    var selectedAnnotation: MKAnnotation? = nil      //For deselcting selected one when close button is clicked
    var annotationArray = [MKPointAnnotation]()     //For removing rendered annotations
    var polyline = MKPolyline()
    var currentPolylineOverlay = [MKPolyline]()     //For removing rendered polyline
    var tagArray = [String:String]()

    override func viewDidLoad(){
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .dark
        }

        setupView()
        checkLocationAuthorization()
        mapkitView.delegate = self
//        bottomSheetVC.setDelegate(vc: self)
        showInfoOptions()
    }

    func setupView(){
        mapkitView.layoutMargins.bottom = (view.frame.height*0.1)
        view.addSubview(mapkitView)
        _ = mapkitView.anchorWithConstants(top: view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 00, bottomConstant: 0, rightConstant: 0)

    }


    @objc func showInfoOptions(){
        if !UserDefaults.standard.bool(forKey: "firstMap"){
            DispatchQueue.main.async(execute: {
                let alertController = UIAlertController(title: "Welcome to the Maps Tab", message: "• Filter the locations according to your needs.\n\n• Tap on a location bubble to access the directions within the app.\n\n• Alternately, you can navigate to a location through the maps application by tapping on the navigation button.\n\n• Tap on a top-right location button twice to start compass view.", preferredStyle: .actionSheet)

                let okayAction = UIAlertAction(title: "Continue", style: .cancel, handler: { (_) in

                })
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }

        UserDefaults.standard.set(true, forKey: "firstMap")
        UserDefaults.standard.synchronize()
    }


    func setupLocationManager(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }

        func checkLocationAuthorization(){
            switch CLLocationManager.authorizationStatus(){
                case .authorizedWhenInUse:
                    mapkitView.showsUserLocation = true
                    locationManager.startUpdatingLocation()
                    centreViewOnUserLocation()
                    determineMyCurrentLocation()
                    break
                case .denied:
                    showDisabledAlert()
                    break
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    break
                case .restricted:
                    showDisabledAlert()
                    break
                case .authorizedAlways:
                    mapkitView.showsUserLocation = true
                    locationManager.startUpdatingLocation()
                    centreViewOnUserLocation()
                    determineMyCurrentLocation()
                    break
                @unknown default:
                    locationManager.requestWhenInUseAuthorization()
            }
        }

        func showDisabledAlert(){
            // open app settings
            DispatchQueue.main.async(execute: {
                let alertController = UIAlertController(title: "Location Permission Denied", message: "Please allow location access to use the directions feature.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Dimiss", style: .destructive, handler: nil)
                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
                     UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
                alertController.addAction(defaultAction)
                alertController.addAction(settingsAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }

        func centreViewOnUserLocation(){
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
                mapkitView.setRegion(region, animated: true)
            }

        }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation

        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.

       // manager.stopUpdatingLocation()

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    }




