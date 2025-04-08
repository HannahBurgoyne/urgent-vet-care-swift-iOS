import SwiftUI
import MapKit

struct MapView: View {
    var userLocation: CLLocation
    var clinics: [Clinic]

    @State private var region: MKCoordinateRegion
    @State private var selectedClinic: ClinicItem? = nil 

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
            MapAnnotation(coordinate: clinic.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .onTapGesture {
                        fetchClinicDetails(id: Int(clinic.id) ?? 0, coordinate: clinic.coordinate)
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $selectedClinic) { clinicItem in
            ClinicDetailsSheet(coordinates: clinicItem.coordinates, clinic: clinicItem.details)
        }
    }

    private func fetchClinicDetails(id: Int, coordinate: CLLocationCoordinate2D) {
        APIService.getClinicDetails(id: id) { result in
            switch result {
            case .success(let details):
                let clinicItem = ClinicItem(coordinates: coordinate, details: details)
                selectedClinic = clinicItem
            case .failure(let error):
                print("Error fetching clinic details: \(error)")
            }
        }
    }
}

struct ClinicItem: Identifiable {
    var id = UUID()
    var coordinates: CLLocationCoordinate2D
    var details: ClinicDetails
}

