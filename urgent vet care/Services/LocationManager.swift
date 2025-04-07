//
//  LocationManager.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//
// LocationManager.swift
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation? // The current location of the user
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization() // Request location permission
        locationManager.startUpdatingLocation() // Start receiving location updates
    }
    
    // This method is called when the location manager updates the user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation // Update the userLocation property
    }
    
    // This method is called when there is an error in retrieving location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
    
    // Request permission if not already granted
    func requestLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
