//
//  SeasonRowView.swift
//  TECH ASSIG
//
//  Created by Akhil Gubbala on 19/02/25.
//

import SwiftUI

struct SeasonRow: View {
    let season: Season

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: season.posterURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 5) {
                Text(season.name)
                    .foregroundStyle(.white)
                    .font(.headline)
//                Text(season.overview)
//                    .foregroundStyle(.white)
//                    .font(.subheadline)
//                    .lineLimit(3)
                Text("Episodes: \(season.episodeCount)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
