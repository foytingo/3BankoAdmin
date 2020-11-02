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
    var predict1: Predict?
    var predict2: Predict?
    var predict3: Predict?
    
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
        let prediction = Prediction(date: self.date, id: self.id, predict1: self.predict1!, predict2: self.predict2!, predict3: self.predict3!)
        print("DEBUG: \(prediction)")
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
            cell.detailTextLabel?.text = "Ayarla"
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
            case 0: print("uuid")
            case 1: print("tarih saat")
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
