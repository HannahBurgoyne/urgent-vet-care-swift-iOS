//
//  Clinic.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//


struct Clinic: Identifiable, Codable {
    var id: String
    var name: String
    var formattedAddress: String
    var rating: Double?
    var openingHours: OpeningHours?

    struct OpeningHours: Codable {
        var openNow: Bool
    }
}
