import SwiftUI
import MapKit

struct MapView: View {
    var userLocation: CLLocation
    var clinics: [Clinic]
    
    @State private var region: MKCoordinateRegion
    
    init(userLocation: CLLocation, clinics: [Clinic]) {
        self.userLocation = userLocation
        self.clinics = clinics
        _region = State(initialValue: MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: clinics) { clinic in
            // Add MapAnnotation for each clinic
            MapPin(coordinate: CLLocationCoordinate2D(latitude: clinic.location.lat, longitude: clinic.location.lng), tint: .red)
        }
        .onAppear {
            region.center = userLocation.coordinate
        }
        .edgesIgnoringSafeArea(.all)
    }
}
