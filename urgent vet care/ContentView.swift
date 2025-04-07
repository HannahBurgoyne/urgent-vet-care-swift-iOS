//
//  ContentView.swift
//  urgent vet care
//
//  Created by Hannah Burgoyne on 07/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var clinics: [Clinic] = []  // Store the list of clinics
    @State private var isLoading = true        // Loading state
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    ClinicListView()
                }
            }
            .onAppear {
                loadClinics()
            }
            .navigationTitle("Urgent Vet Care")
        }
    }
    
    private func loadClinics() {
        APIService.getClinics { result in
            switch result {
            case .success(let fetchedClinics):
                clinics = fetchedClinics
                isLoading = false
            case .failure(let error):
                // Handle the error, show an alert or something
                print("Error fetching clinics: \(error)")
                isLoading = false
            }
        }
    }
}


