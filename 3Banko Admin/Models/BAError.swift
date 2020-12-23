//
//  3BAError.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 23.12.2020.
//

import Foundation

enum BAError: String, Error {
    
    case invalidURL = "This url created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
