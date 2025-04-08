import SwiftUI

struct ClinicDetailsSheet: View {
    let clinic: ClinicDetails

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

                VStack(alignment: .leading, spacing: 4) {
                    ForEach(clinic.openingHours.weekdayText, id: \.self) { dayText in
                        Text("📅 \(dayText)")
                            .font(.caption)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
    }
}
