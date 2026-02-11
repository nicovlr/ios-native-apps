import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(sort: \SavedRecipe.savedAt, order: .reverse) private var saved: [SavedRecipe]

    var body: some View {
        NavigationStack {
            Group {
                if saved.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text("Recipes you save will appear here.")
                    )
                } else {
                    List(saved) { item in
                        FavoriteRow(saved: item)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteRow: View {
    let saved: SavedRecipe

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.quaternary)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red.opacity(0.5))
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(saved.title)
                    .font(.headline)
                HStack {
                    Text(saved.cuisine)
                    Text("·")
                    Text(saved.savedAt, style: .relative)
                        .foregroundStyle(.tertiary)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}
