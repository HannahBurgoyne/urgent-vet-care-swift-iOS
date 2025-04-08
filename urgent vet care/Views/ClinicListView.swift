import SwiftUI

struct ClinicListView: View {
    var clinics: [Clinic] 

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
        }
    }

    var filteredClinics: [Clinic] {
        clinics.filter { $0.openingHours?.openNow == true }
    }
}

