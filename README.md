# Flavour

A native iOS recipe discovery app built entirely in **SwiftUI** with **SwiftData** persistence. Browse recipes by cuisine, search by ingredient, and save favorites offline.

Targets **iOS 17+** with modern Swift concurrency patterns.

## Features

- **Home Feed** — Featured recipe hero card with horizontal category browsing via `LazyHStack`
- **Search** — Real-time ingredient and recipe name search with suggestion chips
- **Favorites** — Save/unsave recipes with SwiftData persistence, reactive UI via `@Query`
- **Detail View** — Full recipe display with animated save button (`symbolEffect(.bounce)`)
- **Design System** — Centralized `Theme` enum with spacing, color, and corner radius tokens
- **Custom Animations** — Spring-based `ScaleButtonStyle`, gradient material cards

## Architecture

Feature-based module structure with a shared Core layer.

```
Flavour/
├── App/                 # Entry point, SwiftData container, tab navigation
├── Features/
│   ├── Home/            # Feed, category sections, featured card
│   ├── Search/          # Ingredient search, suggestions
│   ├── Detail/          # Recipe detail, save/unsave logic
│   └── Favorites/       # Saved recipes list with @Query
├── Core/
│   ├── Design/          # Theme tokens, RecipeCardView, ScaleButtonStyle
│   ├── Networking/      # Generic async APIClient with typed error handling
│   └── Persistence/     # SwiftData @Model for offline favorites
└── Shared/              # View extensions, Color(hex:) initializer
```

## Technical Highlights

| Area | Implementation |
|------|---------------|
| UI Framework | SwiftUI with `NavigationStack`, type-safe routing via `.navigationDestination(for:)` |
| Persistence | SwiftData `@Model` + `#Predicate` queries + `@Query` property wrapper |
| Networking | Generic `async/await` API client with `Decodable` constraint, snake_case key decoding |
| State | `@State`, `@Environment(\.modelContext)` for SwiftData CRUD operations |
| Design System | Token-based `Theme` enum, custom `ButtonStyle`, gradient materials, `FlowLayout` |
| Navigation | Tab-based root with `NavigationStack` per tab, value-based programmatic navigation |
| Testing | Unit tests for data model integrity (unique IDs, required fields, valid prep times) |

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+
