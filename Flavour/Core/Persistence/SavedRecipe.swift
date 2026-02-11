import Foundation
import SwiftData

@Model
final class SavedRecipe {
    var recipeId: String
    var title: String
    var cuisine: String
    var imageURL: String?
    var savedAt: Date

    init(from recipe: Recipe) {
        self.recipeId = recipe.id
        self.title = recipe.title
        self.cuisine = recipe.cuisine
        self.imageURL = recipe.imageURL
        self.savedAt = .now
    }
}
