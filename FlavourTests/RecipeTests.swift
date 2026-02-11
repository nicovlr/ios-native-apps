import XCTest
@testable import Flavour

final class RecipeTests: XCTestCase {
    func testSamplesNotEmpty() {
        XCTAssertFalse(Recipe.samples.isEmpty)
    }

    func testSamplesHaveUniqueIDs() {
        let ids = Recipe.samples.map(\.id)
        XCTAssertEqual(ids.count, Set(ids).count, "Duplicate recipe IDs found")
    }

    func testAllRecipesHaveIngredients() {
        for recipe in Recipe.samples {
            XCTAssertFalse(recipe.ingredients.isEmpty, "\(recipe.title) has no ingredients")
        }
    }

    func testAllRecipesHaveSteps() {
        for recipe in Recipe.samples {
            XCTAssertFalse(recipe.steps.isEmpty, "\(recipe.title) has no steps")
        }
    }

    func testPrepTimePositive() {
        for recipe in Recipe.samples {
            XCTAssertGreaterThan(recipe.prepTime, 0)
        }
    }
}
