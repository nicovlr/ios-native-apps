import Foundation

struct Recipe: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let cuisine: String
    let ingredients: [String]
    let steps: [String]
    let prepTime: Int // minutes
    let difficulty: Difficulty
    let imageURL: String?

    enum Difficulty: String, Codable, CaseIterable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
}

extension Recipe {
    static let samples: [Recipe] = [
        Recipe(
            id: "r1",
            title: "Tonkotsu Ramen",
            cuisine: "Japanese",
            ingredients: ["pork bones", "soy sauce", "miso paste", "noodles", "chashu pork", "soft-boiled egg", "green onions", "nori"],
            steps: [
                "Boil pork bones for 8-12 hours on medium heat",
                "Prepare tare with soy sauce and miso",
                "Cook noodles separately until al dente",
                "Slice chashu, halve the eggs",
                "Assemble: broth, tare, noodles, toppings"
            ],
            prepTime: 45,
            difficulty: .hard,
            imageURL: nil
        ),
        Recipe(
            id: "r2",
            title: "Cacio e Pepe",
            cuisine: "Italian",
            ingredients: ["tonnarelli pasta", "pecorino romano", "black pepper"],
            steps: [
                "Cook pasta in salted water, reserve pasta water",
                "Toast cracked black pepper in a pan",
                "Mix grated pecorino with a bit of pasta water to form a cream",
                "Toss pasta with pepper and cheese cream",
                "Serve immediately"
            ],
            prepTime: 20,
            difficulty: .medium,
            imageURL: nil
        ),
        Recipe(
            id: "r3",
            title: "Tacos al Pastor",
            cuisine: "Mexican",
            ingredients: ["pork shoulder", "achiote paste", "pineapple", "corn tortillas", "onion", "cilantro", "lime"],
            steps: [
                "Marinate pork in achiote, garlic, vinegar overnight",
                "Grill pork with pineapple slices",
                "Slice thin, chop pineapple",
                "Warm tortillas on the comal",
                "Top with meat, pineapple, onion, cilantro, lime"
            ],
            prepTime: 35,
            difficulty: .medium,
            imageURL: nil
        ),
        Recipe(
            id: "r4",
            title: "Croque Monsieur",
            cuisine: "French",
            ingredients: ["bread", "gruyère", "ham", "béchamel", "butter", "dijon mustard"],
            steps: [
                "Make béchamel: butter, flour, milk, nutmeg",
                "Spread mustard on bread, layer ham and cheese",
                "Top with béchamel and more gruyère",
                "Bake at 200°C until golden and bubbly"
            ],
            prepTime: 25,
            difficulty: .easy,
            imageURL: nil
        ),
        Recipe(
            id: "r5",
            title: "Butter Chicken",
            cuisine: "Indian",
            ingredients: ["chicken thighs", "yogurt", "garam masala", "tomatoes", "butter", "cream", "garlic", "ginger", "kasuri methi"],
            steps: [
                "Marinate chicken in yogurt, spices for 2h minimum",
                "Grill or pan-sear chicken until charred",
                "Cook tomato sauce with garlic, ginger, spices",
                "Add butter, cream, kasuri methi",
                "Combine chicken with sauce, simmer 10 min"
            ],
            prepTime: 40,
            difficulty: .medium,
            imageURL: nil
        ),
    ]
}
