//
//  BOAErrors.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 6.11.2020.
//

import Foundation

enum BOAErrors: String, Error {
    case addPredictError = "Tahmin eklenemedi. Tekrar deneyiniz."
    case infoButton = "Info button mesaji burada olacak."
    case getAllPredictError = "Tahminler yuklenemedi. Tekrar deneyiniz."
    case authError = "Admin olarak giris yapilamadi. Tekrar deneyiniz."
    case updateError = "Tahmin sonuclari kaydedilemedi. Tekrar deneyiniz."
}
