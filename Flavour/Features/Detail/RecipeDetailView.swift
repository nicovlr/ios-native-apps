import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.modelContext) private var modelContext
    @State private var isSaved = false
    @State private var showSavedFeedback = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.spacingL) {
                headerSection
                infoBar
                ingredientsSection
                stepsSection
            }
            .padding()
        }
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    toggleSaved()
                } label: {
                    Image(systemName: isSaved ? "heart.fill" : "heart")
                        .foregroundStyle(isSaved ? .red : .secondary)
                        .symbolEffect(.bounce, value: showSavedFeedback)
                }
            }
        }
        .task {
            checkIfSaved()
        }
    }

    private var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: Theme.cornerLarge)
                .fill(.ultraThinMaterial)
                .frame(height: 200)
                .overlay {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)
                }

            Text(recipe.cuisine)
                .font(.caption.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(14)
        }
    }

    private var infoBar: some View {
        HStack(spacing: 24) {
            InfoChip(icon: "clock", text: "\(recipe.prepTime) min")
            InfoChip(icon: "chart.bar", text: recipe.difficulty.rawValue)
            InfoChip(icon: "list.bullet", text: "\(recipe.ingredients.count) ingredients")
        }
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients")
                .font(.title3.bold())

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                HStack(spacing: 10) {
                    Circle()
                        .fill(Theme.accent)
                        .frame(width: 6, height: 6)
                    Text(ingredient)
                }
            }
        }
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Steps")
                .font(.title3.bold())

            ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: 12) {
                    Text("\(index + 1)")
                        .font(.headline)
                        .foregroundStyle(Theme.accent)
                        .frame(width: 28)
                    Text(step)
                        .font(.body)
                }
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Persistence

    private func checkIfSaved() {
        let id = recipe.id
        let descriptor = FetchDescriptor<SavedRecipe>(
            predicate: #Predicate { $0.recipeId == id }
        )
        isSaved = (try? modelContext.fetchCount(descriptor)) ?? 0 > 0
    }

    private func toggleSaved() {
        if isSaved {
            // remove
            let id = recipe.id
            let descriptor = FetchDescriptor<SavedRecipe>(
                predicate: #Predicate { $0.recipeId == id }
            )
            if let existing = try? modelContext.fetch(descriptor).first {
                modelContext.delete(existing)
            }
        } else {
            // save
            let saved = SavedRecipe(from: recipe)
            modelContext.insert(saved)
        }
        isSaved.toggle()
        showSavedFeedback.toggle()
    }
}

struct InfoChip: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .foregroundStyle(.secondary)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.quaternary, in: Capsule())
    }
}
