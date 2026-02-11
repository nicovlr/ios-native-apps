import SwiftUI

struct HomeView: View {
    @State private var recipes: [Recipe] = Recipe.samples
    @State private var isLoading = false

    private var categories: [String] {
        Array(Set(recipes.map(\.cuisine))).sorted()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: Theme.spacingL) {
                    // featured
                    if let featured = recipes.first {
                        NavigationLink(value: featured) {
                            FeaturedRecipeView(recipe: featured)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }

                    // by category
                    ForEach(categories, id: \.self) { category in
                        CategorySection(
                            title: category,
                            recipes: recipes.filter { $0.cuisine == category }
                        )
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Flavour")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .refreshable {
                await loadRecipes()
            }
        }
    }

    private func loadRecipes() async {
        isLoading = true
        // using mock for now
        try? await Task.sleep(for: .milliseconds(400))
        recipes = APIClient.shared.loadMockRecipes()
        isLoading = false
    }
}

struct FeaturedRecipeView: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: Theme.cornerLarge)
                .fill(
                    LinearGradient(
                        colors: [.orange.opacity(0.4), .pink.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 220)

            VStack(alignment: .leading, spacing: 6) {
                Text("Featured")
                    .font(.caption.bold())
                    .textCase(.uppercase)
                    .foregroundStyle(.white.opacity(0.7))
                Text(recipe.title)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding(20)
        }
    }
}

struct CategorySection: View {
    let title: String
    let recipes: [Recipe]

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacingS) {
            Text(title)
                .font(.title3.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 14) {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCardView(recipe: recipe, compact: true)
                                .frame(width: 160)
                        }
                        .buttonStyle(.scale)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
