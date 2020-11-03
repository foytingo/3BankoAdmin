//
//  FirebaseManager.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 3.11.2020.
//

import Firebase

struct FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    func getAllPredictions(completion: @escaping ([[String: Any]], Error?) -> Void) {
        var allPredictsArray = [[String: Any]]()
        
        db.collection("predicts").order(by: "id", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(allPredictsArray, error)
            } else {
                for document in snapshot!.documents {
                    allPredictsArray.append(document.data())
                }

                completion(allPredictsArray,error)
            }
        }
    }
    
    func authAnonymous(completion: @escaping(String, Error?) -> Void) {
        var uid = ""
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                completion(uid, error)
            } else {
                guard let user = authResult?.user else { return }
                uid = user.uid
                completion(uid,error)
            }
        }
    }
    
    func addNewPrediction(prediction: Prediction, completion: @escaping(Error?)-> Void) {
        let predict1: [String: Any] = ["date": prediction.predict0.dateAndTime,
                                       "isFree": prediction.predict0.isFree,
                                       "isOk": prediction.predict0.isOk,
                                       "name": prediction.predict0.name,
                                       "odd": prediction.predict0.odd,
                                       "organization": prediction.predict0.org,
                                       "prediction": prediction.predict0.predict,
                                       "result": prediction.predict0.result,
                                       "uuid": prediction.predict0.uuid]
      
        let predict2: [String: Any] = ["date": prediction.predict1.dateAndTime,
                                       "isFree": prediction.predict1.isFree,
                                       "isOk": prediction.predict1.isOk,
                                       "name": prediction.predict1.name,
                                       "odd": prediction.predict1.odd,
                                       "organization": prediction.predict1.org,
                                       "prediction": prediction.predict1.predict,
                                       "result": prediction.predict1.result,
                                       "uuid": prediction.predict1.uuid]
       
        let predict3: [String: Any] = ["date": prediction.predict2.dateAndTime,
                                       "isFree": prediction.predict2.isFree,
                                       "isOk": prediction.predict2.isOk,
                                       "name": prediction.predict2.name,
                                       "odd": prediction.predict2.odd,
                                       "organization": prediction.predict2.org,
                                       "prediction": prediction.predict2.predict,
                                       "result": prediction.predict2.result,
                                       "uuid": prediction.predict2.uuid]
        
        db.collection("predicts").addDocument(data: [
            "date": prediction.date,
            "id": prediction.id,
            "predict1": predict1,
            "predict2": predict2,
            "predict3": predict3], completion: completion)
    }
}


