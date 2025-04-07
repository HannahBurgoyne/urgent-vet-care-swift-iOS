//
//  APIService.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//

import Foundation

class APIService {
    static func getClinics(completion: @escaping (Result<[Clinic], Error>) -> Void) {
        // Simulate network delay by using DispatchWorkItem
        let workItem = DispatchWorkItem {
            let mockData: [Clinic] = [
                Clinic(id: "1", name: "Pawfect Urgent Care", formattedAddress: "123 Doggo St", rating: 4.7, openingHours: Clinic.OpeningHours(openNow: true)),
                Clinic(id: "2", name: "Emergency Vet Clinic", formattedAddress: "456 Cat Ln", rating: 4.2, openingHours: Clinic.OpeningHours(openNow: false)),
                Clinic(id: "3", name: "24/7 Animal Hospital", formattedAddress: "789 Bunny Blvd", rating: 4.9, openingHours: Clinic.OpeningHours(openNow: true))
            ]
            
            DispatchQueue.main.async {
                completion(.success(mockData))
            }
        }
        
        // Delaying the workItem execution by 1 second
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }
}
