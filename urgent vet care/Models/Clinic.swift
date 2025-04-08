//
//  Clinic.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//

import MapKit


struct Clinic: Identifiable, Codable {
    var id: String
    var name: String
    var formattedAddress: String
    var rating: Double?
    var openingHours: OpeningHours?
    var location: Location
    var coordinate: CLLocationCoordinate2D {
          CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
      }
    var placeId: String
    var businessStatus: String
    

    struct OpeningHours: Codable {
        var openNow: Bool
    }

    struct Location: Codable {
        var lat: Double
        var lng: Double
    }
}



