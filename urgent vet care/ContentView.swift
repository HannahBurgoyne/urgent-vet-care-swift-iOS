import SwiftUI

struct ContentView: View {
    @State private var clinics: [Clinic] = []
    @State private var isLoading = true
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    if let userLocation = locationManager.userLocation {
                        MapView(userLocation: userLocation, clinics: clinics) 
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
