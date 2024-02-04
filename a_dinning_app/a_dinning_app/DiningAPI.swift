//
//  DiningViewModel.swift
//  a_dinning_app
//
//  Created by on 2/4/24.
//

import SwiftUI
import Combine

struct DiningVenue: Decodable, Identifiable, Hashable {
    var id: Int
    var name: String
    var status: String
    var hours: [String]
    var imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, status, hours, imageUrl = "imageURL"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        let hoursContainer = try container.decode([String: [String]].self, forKey: .hours)
        hours = hoursContainer.flatMap { $0.value }
    }

    var formattedTimes: String {
        switch hours.count {
        case 0:
            return "CLOSED"
        case 1:
            return hours.first!
        default:
            return hours.joined(separator: " | ")
        }
    }
}


class DiningViewModel: ObservableObject {
    @Published var diningVenues: [DiningVenue] = []
    private var cancellables = Set<AnyCancellable>()

    func loadDiningData() {
        let url = URL(string: "https://pennmobile.org/api/dining/venues/")!
        let backupUrl = URL(string: "https://pennlabs.github.io/backup-data/venues.json")!

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .catch { _ in URLSession.shared.dataTaskPublisher(for: backupUrl).map(\.data).eraseToAnyPublisher() }
            .decode(type: [DiningVenue].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    print("Retrieving data failed with error \(err)")
                }
            }, receiveValue: { [weak self] diningVenues in
                self?.diningVenues = diningVenues
            })
            .store(in: &cancellables)
    }
    
    init() {
            loadDiningData()
    }
}
