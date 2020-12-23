//
//  String+Ext.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 23.12.2020.
//

import Foundation

extension String {
    func switcgPredictName() -> String {
        switch self {
        case "Maç Sonucu":
            return "MS"
        case "İlk Yarı Sonucu":
            return ""
            
        case "Alt / Üst (0,5)":
            return "MS 0,5"
        case "Alt / Üst (1,5)":
            return "MS 1,5"
        case "Alt / Üst (2,5)":
            return "MS 2,5"
        case "Alt / Üst (3,5)":
            return "MS 3,5"
        case "Alt / Üst (4,5)":
            return "MS 4,5"
            
        case "Karşılıklı Gol":
            return "KG"
        case "Çifte Şans":
            return "ÇŞ"
        case "Toplam Gol Sayısı":
            return "TG"
        case "İlk Yarı Alt / Üst (1,5)":
            return "İY 1,5"
        default:
            return self
        }
    
        
    }
}
