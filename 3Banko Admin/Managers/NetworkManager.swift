//
//  NetworkManager.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 23.12.2020.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getCoupon(for url: String?, completed: @escaping(Result<Coupon,BAError>) -> Void){
        let components = NSURL(fileURLWithPath: url!).pathComponents!.dropFirst()
        let JSONurl = "https://aping.bilyoner.com/coupon-share/coupons/\(components.last ?? "")"
        
        guard let url = URL(string: JSONurl) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let coupon = try decoder.decode(Coupon.self, from: data)
                completed(.success(coupon))
            }catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getOrg(matchCode: Int, completed: @escaping(Result<String,BAError>) -> Void){
        // var organizations: Dictionary = [matchCodes[0]: "", matchCodes[1]: "", matchCodes[2]: ""]
        
        guard let url = URL(string: "https://aping.bilyoner.com/mobile/match-card/\(matchCode)/header") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let matchDetail = try decoder.decode(MatchDetail.self, from: data)
                completed(.success(matchDetail.tournament.tournamentName))
            }catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
        
        
        
    }
    
    
}
