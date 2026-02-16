import UIKit

/// Centralized haptic feedback manager.
/// Wraps UIKit feedback generators for consistent haptic responses across the app.
enum HapticManager {

    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare(); generator.impactOccurred()
    }

    /// Light tap for card selection, toggle state changes.
    static func lightTap() { impact(.light) }

    /// Medium tap for button presses, navigation actions.
    static func mediumTap() { impact(.medium) }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare(); generator.notificationOccurred(type)
    }

    /// Success feedback for save, bookmark, completed actions.
    static func success() { notification(.success) }

    /// Error feedback for failed actions, validation errors.
    static func error() { notification(.error) }

    /// Selection change feedback for pickers, tab switches.
    static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare(); generator.selectionChanged()
    }
}
