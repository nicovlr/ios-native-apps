import SwiftUI

/// Utilities for matched geometry effect hero transitions between recipe cards and detail views.
enum HeroTransition {
    static func imageID(for recipeID: String) -> String { "hero-image-\(recipeID)" }
    static func titleID(for recipeID: String) -> String { "hero-title-\(recipeID)" }
}

struct HeroSourceModifier: ViewModifier {
    let recipeID: String
    let namespace: Namespace.ID
    func body(content: Content) -> some View {
        content.matchedGeometryEffect(id: HeroTransition.imageID(for: recipeID), in: namespace)
    }
}

struct HeroDestinationModifier: ViewModifier {
    let recipeID: String
    let namespace: Namespace.ID
    func body(content: Content) -> some View {
        content.matchedGeometryEffect(id: HeroTransition.imageID(for: recipeID), in: namespace)
    }
}

extension View {
    func heroSource(recipeID: String, namespace: Namespace.ID) -> some View {
        modifier(HeroSourceModifier(recipeID: recipeID, namespace: namespace))
    }
    func heroDestination(recipeID: String, namespace: Namespace.ID) -> some View {
        modifier(HeroDestinationModifier(recipeID: recipeID, namespace: namespace))
    }
}
