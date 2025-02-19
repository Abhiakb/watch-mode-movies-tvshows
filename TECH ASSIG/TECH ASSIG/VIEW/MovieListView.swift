//
//  View1.swift
//  TECH ASSIG
//
//  Created by Akhil Gubbala on 17/02/25.
//
import SwiftUI
import Combine

struct MovieListView: View {
    @State var selectedoption: ToggleOption = .movies
    @StateObject private var viewModel = MoviesViewModel()
    @StateObject private var  seasonsviewModel = SeasonsViewModel()

 
    @State var selected: Bool = true
    enum ToggleOption{
        case movies , TvShows
    }
    var body: some View {
        
        NavigationView {
            ZStack{
                Color.black.ignoresSafeArea(.all)
                VStack{
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.gray.opacity(0.7), lineWidth: 1.5)
                                .frame(width: 250,height: 50)
                            HStack{
                                RoundedRectangle(cornerRadius: 41)
                                    .fill(Color.green)
                                    .frame(width: 120, height: 40)
                                    .offset(x: selectedoption == .movies ? -60 : 60)
                                    .animation(.easeInOut(duration: 0.2), value: selectedoption)
                            }
                            .frame(width: 300, height: 40)
                            HStack(spacing: 0) {
                                Button(action: {
                                    withAnimation {
                                        selectedoption = .movies
                                    }
                                }) {
                                    Text("movies")
                                        .frame(width: 120, height: 40)
                                        .font(.custom("Poppins-Medium", size: 14))
                                        .foregroundColor(selectedoption == .movies ? .white : .gray)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        selectedoption = .TvShows
                                    }
                                }) {
                                    Text("TvShows")
                                        .frame(width: 120, height: 40)
                                        .font(.custom("Poppins-Medium", size: 14))
                                        .foregroundColor(selectedoption == .TvShows ? .white : .gray)
                                }
                            }
                        }
                        
                        
                    }
                    if selectedoption == .movies {
                        
                            ZStack{
                                Color.black.ignoresSafeArea(.all)
                                ScrollView {
                                    LazyVStack {
                                        if viewModel.isLoading {
                                            ForEach(0..<5, id: \.self) { _ in
                                                MovieRowPlaceholder()
                                            }
                                        } else {
                                            ForEach(viewModel.movies) { movie in
                                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                    MovieRow(movie: movie)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                          
                    }
                    else if selectedoption == .TvShows {
                        
                        SeasonsListView()
                    }            }
                
                
                
            }
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}
struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let posterURL = movie.posterURL, let url = URL(string: posterURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(height: 300)
                        .cornerRadius(10)
                    }
                    
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    
                    Text("Type: \(movie.type)")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        
                    
                    if let imdbID = movie.imdbID {
                        Text("IMDB ID: \(imdbID)")
                            .foregroundStyle(.white)
                    }
                    
                    if let tmdbID = movie.tmdbID {
                        Text("TMDB ID: \(tmdbID)")
                            .foregroundStyle(.white)
                    }
                    
                    if let releaseDate = movie.sourceReleaseDate {
                        Text("Release Date: \(releaseDate)")
                            .foregroundStyle(.white)
                    }
                    
                    if let sourceName = movie.sourceName {
                        Text("Source: \(sourceName)")
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
