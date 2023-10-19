//
//  AppCategoryModel.swift
//  PodcastApp
//
//  Created by Vanopr on 27.09.2023.
//

import Foundation

struct AppCategoryModel {
    static let categoryNames = [
        "Popular 🔥",
        "Recent",
        "News"
        ,"Music",
        "Home",
        "Travel",
        "Design",
        "Film",
        "TV",
        "Food",
        "Language"]
    
    static let combinedCategories = [
        "Music & Life",
        "News & Technology",
        "History & Culture",
        "TV & Film",
        "Cryptocurrency & Business",
        "Health & Fitness",
        "Technology & Business",
        "Travel & Places",
        "Nature & Physics",
        "Life & Home",
        "Hobbies & Sports"
    ]
    
    static let combinedCategoriesImages = [
        "MusicLife",
        "NewsTechnology",
        "HistoryCulture",
        "TVFilm",
        "CryptocurrencyBusiness",
        "HealthFitness",
        "TechnologyBusiness",
        "TravelPlaces",
        "NaturePhysics",
        "LifeHome",
        "HobbiesSports"
    ]
    
    static func splitCategories() -> [String] {
        var resultCategories: [String] = []

        for category in combinedCategories {
            let words = category.components(separatedBy: " & ")
            let formattedCategory = words.joined(separator: ",")
            resultCategories.append(formattedCategory)
        }

        return resultCategories
    }
}


