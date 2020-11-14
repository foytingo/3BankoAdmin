//
//  EnterPredictOfDayVC.swift
//  3Banko Admin
//
//  Created by Murat Baykor on 2.11.2020.
//

import UIKit

class EnterPredictOfDayVC: BOADataLoadingViewController {
    
    var date: String = ""
    var id = 0

    var predictArray = [
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: false, isOk: false, result: "0-0"),
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: false, isOk: false, result: "0-0"),
        Predict(uuid: UUID().uuidString, dateAndTime: "", name: "", org: "", predict: "", odd: "", isFree: false, isOk: false, result: "0-0")
    ]
    
    var cellTextLabels = ["UUID","Tarih ve Saat", "Kiminle kim?", "Organizasyon", "Tahmin", "Oran", "Bedava", "Durum", "Sonuc"]
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var idCell = UITableViewCell(style: .value1, reuseIdentifier: "idCell")
    var dateCell = UITableViewCell(style: .value1, reuseIdentifier: "dateCell")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        date = currentDateWithFormatted()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        configureTableView()
        configureCells()
        
    }
    
    func configureView() {
        title = "Tahmin Gir"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        
    }
    
    func currentDateWithFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let trLocale = Locale(identifier: "tr_TR")
        dateFormatter.locale = trLocale
        
        return dateFormatter.string(from: Date())
    }
    
    @objc func doneAction() {
        showLoadingView()
        let prediction = Prediction(date: date, id: id, isResulted: false, predict0: predictArray[0], predict1: predictArray[1], predict2: predictArray[2])
        FirebaseManager.shared.addNewPrediction(prediction: prediction) { (error) in
            self.dismissLoadingView()
            if error != nil {
                self.presentAlertWithOk(message: BOAErrors.getAllPredictError.rawValue)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    private func configureCells() {
        idCell.textLabel?.text = "ID"
        idCell.detailTextLabel?.text = "\(id)"
        idCell.isUserInteractionEnabled = false
        dateCell.textLabel?.text = "Tarih"
        dateCell.detailTextLabel?.text = date
        dateCell.isUserInteractionEnabled = false
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SetFieldCell.self, forCellReuseIdentifier: "Cell")
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
            return 7
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
            case 0: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].uuid
            case 1: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].dateAndTime
            case 2: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].name
            case 3: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].org
            case 4: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].predict
            case 5: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].odd
            case 6: cell.detailTextLabel?.text = predictArray[indexPath.section - 1].isFree ? "Evet": "Hayir"
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
//        case 0:
//            switch indexPath.row {
//            case 0: print("DEBUG: ID cant change.")
//            case 1: print("DEBUG: Date cant change.")
//            default: fatalError("Unknown row in section 0")
//            }
        case 1,2,3:
            switch indexPath.row {
//            case 0: print("DEBUG: uuid of Tahmin: \(indexPath.section) = \(predictArray[indexPath.section-1].uuid)")
            case 1: presentCustomAlertOnMainThread(title: "saat", alertType: .dateAndTime, delegate: self, indexPath: indexPath)
            case 2: presentCustomAlertOnMainThread(title: "Kiminle Kim", alertType: .match, delegate: self, indexPath: indexPath)
            case 3: presentCustomAlertOnMainThread(title: "Organizasyon", alertType: .org, delegate: self, indexPath: indexPath)
            case 4: presentCustomAlertOnMainThread(title: "Tahminin Ne?", alertType: .predict, delegate: self, indexPath: indexPath)
            case 5: presentCustomAlertOnMainThread(title: "Oran Kac", alertType: .odd, delegate: self, indexPath: indexPath)
            case 6:
                predictArray[indexPath.section - 1].isFree.toggle()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            default: fatalError("Unknown row in section 1")
            }
        default:
            fatalError("Unkwon section")
        }
        
    }
}


extension EnterPredictOfDayVC: CutomAlertBoxViewControllerDelegate {
    func didTapOkButton(type: AlertType, text: String, indexPath: IndexPath) {
        switch type {
        case .match:
            predictArray[indexPath.section - 1].name = text
        case .org:
            predictArray[indexPath.section - 1].org = text
        case .predict:
            predictArray[indexPath.section - 1].predict = text
        case .odd:
            predictArray[indexPath.section - 1].odd = text
        case .dateAndTime:
            predictArray[indexPath.section - 1].dateAndTime = "\(date) \(text)"
        }
        tableView.reloadData()
    }
    
    
}

