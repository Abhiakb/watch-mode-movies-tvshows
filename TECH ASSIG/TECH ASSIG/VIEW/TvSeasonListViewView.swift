import SwiftUI


import SwiftUI

struct SeasonsListView: View {
    @StateObject private var viewModel = SeasonsViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                if viewModel.isLoading {
                    ForEach(0..<5, id: \.self) { _ in
                        SeasonRowPlaceholder()
                    }
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVStack {
                        ForEach(viewModel.seasons) { season in // ✅ Use viewModel.seasons
                            NavigationLink(destination: SeriesDetailsView(season: season)) {
                                SeasonRow(season: season)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchSeasons()
        }
    }
}

struct SeriesDetailsView: View {
    let season: Season

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: season.posterURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 16) {
                Text(season.name)
                    .font(.title)
                    .bold()

                if !season.overview.isEmpty {
                    Text(season.overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                } else {
                    Text("No description available.")
                        .italic()
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(season.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
