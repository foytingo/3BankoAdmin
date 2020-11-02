//
//  EnterPredictOfDayVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class EnterPredictOfDayVC: UIViewController {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    var dateCell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "dateCell")
    
    var predict1Cell: UITableViewCell = UITableViewCell()
    var predict2Cell: UITableViewCell = UITableViewCell()
    var predict3Cell: UITableViewCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tahmin Gir"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        configureTableView()
        configureCells()
    }
    
    @objc func doneAction() {
        print("DEBUG: Done predict button.")
    }
    
    
    @objc func cancelAction() {
        print("DEBUG: Info button action")
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureCells() {
        dateCell.textLabel?.text = "Tarih"
        dateCell.accessoryType = .disclosureIndicator
        dateCell.detailTextLabel?.text = "3 Kasim 2020"
        let predictCells = [predict1Cell, predict2Cell, predict3Cell]
        
        for (index,predictCell) in predictCells.enumerated() {
            predictCell.textLabel?.text = "Tahmin \(index + 1)"
            predictCell.accessoryType = .disclosureIndicator
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension EnterPredictOfDayVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            fatalError("Unknown number of section")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return dateCell
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch indexPath.row {
            case 0: return predict1Cell
            case 1: return predict2Cell
            case 2: return predict3Cell
            default: fatalError("Unknown row in section 1")
            }
        default:
            fatalError("Unkwon section")
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Tahmin Ayarlari"
        case 1: return "Tahminler"
        default: fatalError("Unkwon section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("DEBUG: Start update predict proccess")
    }
    
    
}
