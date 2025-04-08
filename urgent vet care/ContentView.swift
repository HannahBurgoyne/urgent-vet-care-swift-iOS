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
                        ZStack {
                            MapView(userLocation: userLocation, clinics: clinics)
                                .edgesIgnoringSafeArea(.all)
                            
                            // Tab View always on top of the map
                            TabView {
                                // Map View Tab
                                MapView(userLocation: userLocation, clinics: clinics)
                                    .tabItem {
                                        Label("Map", systemImage: "map.fill")
                                    }
                                
                                // Clinic List View Tab
                                ClinicListView(clinics: clinics)
                                    .tabItem {
                                        Label("Clinics", systemImage: "list.bullet")
                                    }
                            }
                            .zIndex(1) // Ensure TabView stays on top
                            .background(Color.white.opacity(0.8)) // Optional: background color for TabView
                        }
                    } else {
                        Text("Fetching location...")
                            .padding()
                    }
                }
            }
            .onAppear {
                // Request location permissions
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
                // Handle error (you can show an alert or message here)
                print("Error fetching clinics: \(error)")
                isLoading = false
            }
        }
    }
}
