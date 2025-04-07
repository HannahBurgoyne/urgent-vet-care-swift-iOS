//
//  ClinicListView.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//


import SwiftUI

struct ClinicListView: View {
    @State private var clinics: [Clinic] = []

    var body: some View {
        NavigationView {
            List(filteredClinics) { clinic in
                VStack(alignment: .leading) {
                    Text(clinic.name)
                        .font(.headline)
                    Text(clinic.formattedAddress)
                        .font(.subheadline)
                    if let rating = clinic.rating {
                        Text("⭐️ \(rating, specifier: "%.1f")")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Open Vet Clinics")
            .onAppear(perform: fetchClinics)
        }
    }

    var filteredClinics: [Clinic] {
        clinics.filter { $0.openingHours?.openNow == true }
    }

    func fetchClinics() {
        APIService.getClinics { result in
            switch result {
            case .success(let clinics):
                self.clinics = clinics
            case .failure(let error):
                print("Error fetching clinics: \(error)")
            }
        }
    }
}
