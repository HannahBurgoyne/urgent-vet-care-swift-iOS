import Foundation

class APIService {
    static func getClinics(completion: @escaping (Result<[Clinic], Error>) -> Void) {
        // Simulate network delay by using DispatchWorkItem
        let workItem = DispatchWorkItem {
            let mockData = clinics
            
            DispatchQueue.main.async {
                completion(.success(mockData))
            }
        }
        
        // Delaying the workItem execution by 1 second
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }
    
    static func getClinicDetails(id: Int, completion: @escaping (Result<ClinicDetails, Error>) -> Void) {
        let workItem = DispatchWorkItem {
            let mockDetails = clinicDetails
            
            DispatchQueue.main.async {
                completion(.success(mockDetails))
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0, execute: workItem)

    }
    
}
