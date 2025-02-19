import Foundation

class SeasonsViewModel: ObservableObject {
    @Published var seasons: [Season] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = SeasonService()

    func fetchSeasons() {
        isLoading = true
        service.fetchSeasons { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let seasons):
                    self.seasons = seasons
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

import Foundation

class SeasonService {
    func fetchSeasons(completion: @escaping (Result<[Season], Error>) -> Void) {
        guard let url = URL(string: "https://api.watchmode.com/v1/title/345534/seasons/?apiKey=gkBS1tOVGAq3lRpc23U6wJbeCZEQf3bkTs58etFD") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400)))
            return
        }

        let request = URLRequest(url: url, timeoutInterval: 10)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500)))
                return
            }

            do {
                let decodedSeasons = try JSONDecoder().decode([Season].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedSeasons))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
