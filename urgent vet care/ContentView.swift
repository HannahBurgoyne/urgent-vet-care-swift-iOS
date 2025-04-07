import SwiftUI

struct ContentView: View {
    @State private var clinics: [Clinic] = []  // Store the list of clinics
    @State private var isLoading = true        // Loading state
    @StateObject private var locationManager = LocationManager() // Location manager for user location
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    // Pass the userLocation to the MapView
                    if let userLocation = locationManager.userLocation {
                        MapView(userLocation: userLocation)
                    } else {
                        Text("Fetching location...")
                            .padding()
                    }
                }
            }
            .onAppear {
                // Request location permissions here
                locationManager.requestLocationPermission()
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

