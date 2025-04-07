import SwiftUI
import MapKit

struct MapView: View {
    var userLocation: CLLocation
    
    @State private var region: MKCoordinateRegion
    
    init(userLocation: CLLocation) {
        self.userLocation = userLocation
        _region = State(initialValue: MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .onAppear {
                region.center = userLocation.coordinate // Update the region to the user's location
            }
            .edgesIgnoringSafeArea(.all)
    }
}
