import XCTest
@testable import Flavour

final class APIClientTests: XCTestCase {
    func testMockRecipesNotEmpty() {
        let recipes = APIClient.shared.loadMockRecipes()
        XCTAssertFalse(recipes.isEmpty)
    }

    func testMockRecipesMatchSamples() {
        let recipes = APIClient.shared.loadMockRecipes()
        XCTAssertEqual(recipes.count, Recipe.samples.count)
    }

    func testAPIErrorDescriptions() {
        let invalidURL = APIError.invalidURL
        XCTAssertNotNil(invalidURL.errorDescription)
        let badResponse = APIError.badResponse(404)
        XCTAssertTrue(badResponse.errorDescription?.contains("404") ?? false)
        let decodingError = APIError.decodingFailed(NSError(domain: "test", code: 0))
        XCTAssertNotNil(decodingError.errorDescription)
    }
}
