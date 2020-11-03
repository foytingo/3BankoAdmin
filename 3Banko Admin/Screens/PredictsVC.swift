//
//  PredictsVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class PredictsVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    var allPredictions = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gunun Tahminleri"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPredict))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonAction))
        view.backgroundColor = .systemRed
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllPredicts()

    }
    
    @objc func addNewPredict() {
        print("DEBUG: Add new predict button.")
        let enterPredictOfDayVC = EnterPredictOfDayVC()
        enterPredictOfDayVC.id = (allPredictions.first?["id"] as! Int) + 1
        navigationController?.pushViewController(enterPredictOfDayVC, animated: true)
    }
    
    
    @objc func infoButtonAction() {
        print("DEBUG: Info button action")
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
        FirebaseManager.shared.getAllPredictions { predictions, error in
            guard let _ = error else {
                self.allPredictions = predictions
                self.tableView.reloadData()
                print("success gettin predicts")
                return
            }
            print("DEBUG: error getting all predicts from database")
        }
    }
    
    private func anonymousLogin() {
        FirebaseManager.shared.authAnonymous { (uid, error) in
            guard let _ = error else {
                print(uid)
                return
            }
            print("DEBUG: Error login")
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
        presentResultCustomAlertOnMainThread(title: "Sonuc Gir", prediction: allPredictions[indexPath.row])
    }
    
    
}
