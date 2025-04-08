
import Foundation

struct ClinicDetails: Identifiable, Codable {
    let id: String
    let name: String
    let openingHours: OpeningHours
    let placeId: String
    let rating: Double
    let website: String
    let formattedPhoneNumber: String
    let formattedAddress: String

    struct OpeningHours: Codable {
        let openNow: Bool
        let periods: [Period]
        let weekdayText: [String]

        struct Period: Codable {
            let open: Time
            let close: Time

            struct Time: Codable {
                let day: Int
                let time: String
            }
        }
    }
}
