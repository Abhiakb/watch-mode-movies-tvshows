//
//  MoviesViewMode.swift
//  TECH ASSIG
//
//  Created by Akhil Gubbala on 17/02/25.
//
import SwiftUI
import Combine
class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = true
    private var cancellables = Set<AnyCancellable>()

    func fetchMovies() {
        guard let url = URL(string: "https://api.watchmode.com/v1/releases/?apiKey=gkBS1tOVGAq3lRpc23U6wJbeCZEQf3bkTs58etFD") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [String: [Movie]].self, decoder: JSONDecoder())
            .map { $0["releases"] ?? [] }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching movies: \(error)")
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
