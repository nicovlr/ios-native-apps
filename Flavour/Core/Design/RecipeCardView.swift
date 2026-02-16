import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    var compact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [colorForCuisine(recipe.cuisine), .gray.opacity(0.15)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .frame(height: compact ? 100 : 160)
                .overlay(alignment: .bottomLeading) {
                    Text(recipe.cuisine.uppercased())
                        .font(.caption2.bold())
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(.ultraThinMaterial, in: Capsule())
                        .padding(10)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(compact ? .subheadline.bold() : .headline)
                    .lineLimit(2)
                if !compact {
                    HStack(spacing: 12) {
                        Label("\(recipe.prepTime)m", systemImage: "clock")
                        Label(recipe.difficulty.rawValue, systemImage: "chart.bar")
                    }
                    .font(.caption).foregroundStyle(.secondary)
                }
            }
            .padding(compact ? 8 : 12)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cornerMedium))
        .shadow(color: Theme.cardShadow, radius: 4, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(recipe.title), \(recipe.cuisine), \(recipe.prepTime) minutes, \(recipe.difficulty.rawValue)")
        .accessibilityHint("Double-tap to view recipe details")
    }

    private func colorForCuisine(_ cuisine: String) -> Color {
        switch cuisine.lowercased() {
        case "japanese": return .red.opacity(0.3)
        case "italian": return .green.opacity(0.3)
        case "mexican": return .yellow.opacity(0.3)
        case "french": return .blue.opacity(0.3)
        case "indian": return .orange.opacity(0.3)
        default: return .gray.opacity(0.2)
        }
    }
}
