//
//  PredictsVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class PredictsVC: BOADataLoadingViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    var allPredictions = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllPredicts()
    }
    
    
    private func configureView() {
        title = "Gunun Tahminleri"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPredict))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonAction))
    }
    
    
    @objc func addNewPredict() {
        let enterPredictOfDayVC = EnterPredictOfDayVC()
        let id = allPredictions.first?["id"] as? Int == nil ? 0 : (allPredictions.first?["id"] as! Int) + 1
        enterPredictOfDayVC.id = id
        navigationController?.pushViewController(enterPredictOfDayVC, animated: true)
    }
    
    
    @objc func infoButtonAction() {
        presentAlertWithOk(message: BOAErrors.infoButton.rawValue)
        FirebaseManager.shared.addDummyPrediction { (error) in
            if let error = error {
                print("DEBUG: Error adding dummy data: \(error)")
            } else {
                print("DEBUG: Successfully added dumy data.")
            }
        }
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    private func getAllPredicts() {
        showLoadingView()
        FirebaseManager.shared.getAllPredictions { predictions, error in
            self.dismissLoadingView()
            guard let _ = error else {
                self.allPredictions = predictions
                self.tableView.reloadData()
                return
            }
            self.presentAlertWithOk(message: BOAErrors.getAllPredictError.rawValue)
        }
    }

}


extension PredictsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPredictions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allPredictions[indexPath.row]["date"] as? String
        cell.backgroundColor = .tertiarySystemBackground
        if allPredictions[indexPath.row]["isResulted"] as! Bool {
            cell.isUserInteractionEnabled = false
            cell.accessoryType = .none
        } else {
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentResultCustomAlertOnMainThread(title: "Sonuç Gir", prediction: allPredictions[indexPath.row])
    }
 
}
