//
//  EnterPredictOfDayVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class EnterPredictOfDayVC: UIViewController {
    
    var date: String = ""
    var id = 0

    var predictArray = [
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: true, isOk: false, result: "0-0"),
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: true, isOk: false, result: "0-0"),
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: true, isOk: false, result: "0-0")
    ]
    
    var cellTextLabels = ["UUID","Tarih ve Saat", "Kiminle kim?", "Organizasyon", "Tahmin", "Oran", "Jetonlu mu?", "Durum", "Sonuc"]
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var idCell = UITableViewCell(style: .value1, reuseIdentifier: "idCell")
    var dateCell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "dateCell")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tahmin Gir"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        let trLocale = Locale(identifier: "tr_TR")
        dateFormatter.locale = trLocale
        date = dateFormatter.string(from: Date())
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        configureTableView()
        configureCells()
        
    }
    
    @objc func doneAction() {
        let prediction = Prediction(date: date, id: id, predict0: predictArray[0], predict1: predictArray[1], predict2: predictArray[2])
        print("DEBUG: Prediction of day: \(prediction)")
        print("DEBUG: Done predict button.")
    }
    
    
    private func configureCells() {
        idCell.textLabel?.text = "ID"
        idCell.detailTextLabel?.text = "\(id)"
        
        dateCell.textLabel?.text = "Tarih"
        dateCell.accessoryType = .disclosureIndicator
        dateCell.detailTextLabel?.text = date
        
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SetFieldCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    private func setDateAndTime(cell: SetFieldCell, indexPath: IndexPath) {
        let ac = UIAlertController(title: "Tarih ve Saat", message: "", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: "Tamam", style: .default) { [weak self, weak ac] action in
            guard let self = self else { return }
            guard let textField = ac?.textFields?[0] else { return }
            guard let text = textField.text else { return }
            if text.isEmpty {
                return
            } else {
                self.predictArray[indexPath.section - 1].dateAndTime = text
                cell.detailTextLabel?.text = self.predictArray[indexPath.section - 1].dateAndTime
                
            }
        }
        
        ac.view.layoutIfNeeded()
        ac.addAction(okAction)
        ac.addAction(UIAlertAction(title: "Iptal", style: .cancel))
        
        present(ac, animated: true)
    }
    
    private func setDate() {
        let ac = UIAlertController(title: "Tarih", message: "Tahmin tarihini ayarla", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: "Tamam", style: .default) { [weak self, weak ac] action in
            guard let self = self else { return }
            guard let textField = ac?.textFields?[0] else { return }
            guard let date = textField.text else { return }
            
            if date.isEmpty {
                return
            } else {
                self.date = date
                self.dateCell.detailTextLabel?.text = date
            }
        }
        
        ac.view.layoutIfNeeded()
        ac.addAction(okAction)
        ac.addAction(UIAlertAction(title: "Iptal", style: .cancel))
        
        present(ac, animated: true)
    }
    
}

extension EnterPredictOfDayVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1, 2, 3:
            return 9
        default:
            fatalError("Unknown number of section")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return idCell
            case 1: return dateCell
            default: fatalError("Unknown row in section 0")
            }
        case 1,2,3:
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SetFieldCell
            cell.textLabel?.text = cellTextLabels[indexPath.row]
            
            switch indexPath.row {
            case 0: cell.detailTextLabel?.text = "Goster"
            case 1: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].dateAndTime
            case 2: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].name
            case 3: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].org
            case 4: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].predict
            case 5: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].odd
            case 6: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].isFree ? "Evet": "Hayir"
            case 7: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].isOk ? "Tuttu": "Tutmadi"
            case 8: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].result
            default: fatalError("unknowns row")
            }
            
            
            return cell
        default: fatalError()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Tahmin Ayarlari"
        case 1: return "Tahmin 1"
        case 2: return "Tahmin 2"
        case 3: return "Tahmin 3"
        default: fatalError("Unkwon section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: print("DEBUG: ID cant change.")
            case 1: setDate()
            default: fatalError("Unknown row in section 0")
            }
        case 1,2,3:
            switch indexPath.row {
            case 0: print("DEBUG: uuid of Tahmin: \(indexPath.section) = \(predictArray[indexPath.section-1].uuid)")
            case 1: setDateAndTime(cell: tableView.cellForRow(at: indexPath) as! SetFieldCell, indexPath: indexPath)
            case 2: print("kimle kim")
            case 3: print("organization")
            case 4: print("tahmin")
            case 5: print("oran")
            case 6: print("jetonlu")
            case 7: print("durum")
            case 8: print("sonuc")
            default: fatalError("Unknown row in section 1")
            }
        default:
            fatalError("Unkwon section")
        }
        
    }
    
    
}
