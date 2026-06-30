//
//  WelcomeView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-29.
//

import SwiftUI

struct WelcomeView: View {
    let favoritesCount: Int

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                heroImage

                Text(Constants.museumName)
                    .font(.system(size: 32, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                Text("Use the Search tab to find artworks by artist, title, or period. Open any result to view details, then tap the heart to save it in Favorites.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 22)
            .padding(.top, 28)
            .padding(.bottom, 18)
        }
    }

    private var heroImage: some View {
        AsyncImage(url: URL(string: "https://web-drupal-cms-prod.clevelandart.org/sites/default/files/2023-12/2022-04-07_DB_Exterior_2022_17.jpg")) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color(.secondarySystemBackground))
                    .overlay { ProgressView() }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "building.columns")
                    .font(.system(size: 56))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 260)
                    .background(Color(.secondarySystemBackground))
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 260)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .accessibilityLabel("Exterior of the Cleveland Museum of Art")
    }
}
