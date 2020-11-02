//
//  PredictsVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class PredictsVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gunun Tahminleri"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPredict))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonAction))
        view.backgroundColor = .systemRed
        
        configureTableView()
    }
    
    @objc func addNewPredict() {
        print("DEBUG: Add new predict button.")
        navigationController?.pushViewController(EnterPredictOfDayVC(), animated: true)
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

}

extension PredictsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .tertiarySystemBackground
        cell.textLabel?.text = "Tarih Burada"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("DEBUG: Start update predict proccess")
    }
    
    
}
