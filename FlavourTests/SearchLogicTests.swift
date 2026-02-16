import XCTest
@testable import Flavour

final class SearchLogicTests: XCTestCase {
    private let allRecipes = Recipe.samples

    private func search(_ query: String) -> [Recipe] {
        let q = query.lowercased().trimmingCharacters(in: .whitespaces)
        guard !q.isEmpty else { return [] }
        return allRecipes.filter { recipe in
            recipe.title.lowercased().contains(q) ||
            recipe.cuisine.lowercased().contains(q) ||
            recipe.ingredients.contains(where: { $0.lowercased().contains(q) })
        }
    }

    func testSearchByTitle() {
        let results = search("ramen")
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Tonkotsu Ramen")
    }

    func testSearchByCuisine() {
        let results = search("italian")
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.allSatisfy { $0.cuisine == "Italian" })
    }

    func testSearchByIngredient() {
        let results = search("chicken")
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.allSatisfy {
            $0.ingredients.contains(where: { $0.lowercased().contains("chicken") })
        })
    }

    func testEmptyQueryReturnsNothing() {
        XCTAssertTrue(search("").isEmpty)
        XCTAssertTrue(search("   ").isEmpty)
    }

    func testNoMatchReturnsEmpty() { XCTAssertTrue(search("sushi").isEmpty) }

    func testCaseInsensitive() {
        XCTAssertEqual(search("japanese").count, search("JAPANESE").count)
    }
}
