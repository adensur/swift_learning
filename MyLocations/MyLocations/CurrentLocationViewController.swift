//
//  ViewController.swift
//  MyLocations
//
//  Created by Maksim Gaiduk on 11/08/2022.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    var location: CLLocation?

    let locationManager = CLLocationManager()
    
    // MARK: - Actions
    @IBAction func getLocation() {
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
          locationManager.requestWhenInUseAuthorization()
          return
        }
        if authStatus == .denied || authStatus == .restricted {
          showLocationServicesDeniedAlert()
          return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        // Do any additional setup after loading the view.
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(
      _ manager: CLLocationManager,
      didFailWithError error: Error
    ) {
      print("didFailWithError \(error.localizedDescription)")
    }

    func locationManager(
      _ manager: CLLocationManager,
      didUpdateLocations locations: [CLLocation]
    ) {
      let newLocation = locations.last!
      location = newLocation
      updateLabels()
      print("didUpdateLocations \(newLocation)")
    }
    
    func updateLabels() {
      if let location = location {
        latitudeLabel.text = String(
          format: "%.8f",
          location.coordinate.latitude)
        longitudeLabel.text = String(
          format: "%.8f",
          location.coordinate.longitude)
        tagButton.isHidden = false
        messageLabel.text = ""
      } else {
        latitudeLabel.text = ""
        longitudeLabel.text = ""
        addressLabel.text = ""
        tagButton.isHidden = true
        messageLabel.text = "Tap 'Get My Location' to Start"
      }
    }
    
    func showLocationServicesDeniedAlert() {
      let alert = UIAlertController(
        title: "Location Services Disabled",
        message: "Please enable location services for this app in Settings.",
        preferredStyle: .alert)

      let okAction = UIAlertAction(
        title: "OK",
        style: .default,
        handler: nil)
      alert.addAction(okAction)

      present(alert, animated: true, completion: nil)
    }
}

