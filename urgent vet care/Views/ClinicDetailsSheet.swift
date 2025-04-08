import SwiftUI
import MapKit

struct ClinicDetailsSheet: View {
    var coordinates: CLLocationCoordinate2D
    var clinic: ClinicDetails
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(clinic.name)
                    .font(.title2)
                    .bold()
                
                Text(clinic.formattedAddress)
                    .font(.subheadline)
                
                Text(clinic.rating > 0 ? "⭐️ Rating: \(String(format: "%.1f", clinic.rating))" : "⭐️ No rating available")
                
                Text(!clinic.formattedPhoneNumber.isEmpty ? "📞 \(clinic.formattedPhoneNumber)" : "📞 No phone number")
                
                clinic.website.isEmpty
                ? AnyView(Text("🌐 No website"))
                : AnyView(Link("🌐 Website:", destination: URL(string: clinic.website)!))
                
                Divider()
                
                Text(clinic.openingHours.openNow ? "🟢 Open Now" : "🔴 Closed Now")
                    .font(.headline)
                
                Text("Today's hours: \(clinic.openingHours.weekdayText[(Calendar.current.component(.weekday, from: Date()) + 5) % 7])")
            }
            
            Button(action: {
                openInAppleMaps()
            }) {
                Text("Get Directions")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
        .padding()
    }
    
    func openInAppleMaps() {
    
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        
        mapItem.name = clinic.name
        
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
