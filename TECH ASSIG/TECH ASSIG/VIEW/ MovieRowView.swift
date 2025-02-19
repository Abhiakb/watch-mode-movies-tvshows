//
//   MovieRowView.swift
//  TECH ASSIG
//
//  Created by Akhil Gubbala on 17/02/25.
//
import SwiftUI
import Combine


struct MovieRow: View {
    let movie: Movie
   
   
   
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: movie.posterURL ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 150)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .foregroundStyle(.white)
                    .font(.headline)
                Text("Source: \(movie.sourceName ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Release: \(movie.sourceReleaseDate ?? "TBA")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}
