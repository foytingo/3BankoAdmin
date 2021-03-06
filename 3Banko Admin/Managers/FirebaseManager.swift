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
    
    
    func authAdminWith(email: String, password: String, completion: @escaping(String? , Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            guard let authData = authData else { return }
            if let error = error {
                completion(nil,error)
            } else {
                let uid = authData.user.uid
                completion(uid,nil)
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
        
        db.collection("predicts").document(prediction.date).setData(["date": prediction.date, "id": prediction.id, "isResulted": prediction.isResulted, "predict1": predict1, "predict2": predict2, "predict3": predict3], completion: completion)
    }
    
    
    func addDummyPrediction(completion: @escaping(Error?)-> Void) {

        let predictModel = Predict(uuid: UUID().uuidString, dateAndTime: "6 Kasim 2020", name: "Galatasray - Fenerbahce", org: "Turkyie super lig", predict: "MS 1", odd: "2.00", isFree: true, isOk: false, result: "0-0")
        
        let predict: [String: Any] = ["date": predictModel.dateAndTime,
                                       "isFree": predictModel.isFree,
                                       "isOk": predictModel.isOk,
                                       "name": predictModel.name,
                                       "odd": predictModel.odd,
                                       "organization": predictModel.org,
                                       "prediction": predictModel.predict,
                                       "result": predictModel.result,
                                       "uuid": predictModel.uuid]
        
        
        for index in 1...60 {
            db.collection("predicts").document(String(index)).setData(["date": String(index), "id": index, "isResulted": false, "predict1": predict, "predict2": predict, "predict3": predict], completion: completion)
        }
    
    }
    
    
    func updateMatchResult(date documentName: String, results:[String?], status: [Bool], isResulted: Bool, completion: @escaping(Error?) -> Void) {

        
        db.collection("predicts").document(documentName).updateData([
            "isResulted": isResulted,
            "predict1.result": results[0]!, "predict1.isOk": status[0],
            "predict2.result": results[1]!, "predict2.isOk": status[1],
            "predict3.result": results[2]!, "predict3.isOk": status[2],
        ], completion: completion)
    }
}


