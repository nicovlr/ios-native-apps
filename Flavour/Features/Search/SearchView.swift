import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var selectedCuisine: String?
    @State private var results: [Recipe] = []

    private let allRecipes = Recipe.samples

    var body: some View {
        NavigationStack {
            List {
                if query.isEmpty && selectedCuisine == nil {
                    suggestionsSection
                } else if results.isEmpty {
                    ContentUnavailableView.search(text: query)
                } else {
                    ForEach(results) { recipe in
                        NavigationLink(value: recipe) {
                            SearchResultRow(recipe: recipe)
                        }
                    }
                }
            }
            .searchable(text: $query, prompt: "Search by ingredient or name")
            .onChange(of: query) { _, newValue in
                performSearch(newValue)
            }
            .navigationTitle("Search")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }

    private var suggestionsSection: some View {
        Section("Popular ingredients") {
            ForEach(["chicken", "pasta", "pork", "cheese"], id: \.self) { suggestion in
                Button {
                    query = suggestion
                } label: {
                    Label(suggestion.capitalized, systemImage: "magnifyingglass")
                }
            }
        }
    }

    private func performSearch(_ text: String) {
        let q = text.lowercased().trimmingCharacters(in: .whitespaces)
        guard !q.isEmpty else {
            results = []
            return
        }
        results = allRecipes.filter { recipe in
            recipe.title.lowercased().contains(q) ||
            recipe.cuisine.lowercased().contains(q) ||
            recipe.ingredients.contains(where: { $0.lowercased().contains(q) })
        }
    }
}

struct SearchResultRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 6)
                .fill(.quaternary)
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: "fork.knife")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.title)
                    .font(.body)
                HStack(spacing: 8) {
                    Text(recipe.cuisine)
                    Text("·")
                    Text("\(recipe.prepTime) min")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}
