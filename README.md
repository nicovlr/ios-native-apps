# Flavour

iOS recipe discovery app. SwiftUI front-end with UIKit integration where needed.

## What it does

Browse recipes by cuisine, search by ingredients, save favorites offline. Clean UI with custom animations.

## Stack

- **SwiftUI** — primary UI framework
- **UIKit** — used for the custom page transitions and collection view layouts
- **Swift Concurrency** — async/await for networking
- **SwiftData** — local persistence for favorites
- **Xcode 15+**, iOS 17+

## Structure

```
Flavour/
├── App/                 # App entry, root navigation
├── Features/
│   ├── Home/            # Main feed, categories
│   ├── Search/          # Ingredient search, filters
│   ├── Detail/          # Recipe detail view
│   └── Favorites/       # Saved recipes
├── Core/
│   ├── Networking/      # API client
│   ├── Persistence/     # SwiftData models
│   └── Design/          # Colors, typography, components
└── Resources/           # Assets, fonts
```

## Status

Working on the detail view transitions and offline caching. Search is functional but needs the filter UI.
