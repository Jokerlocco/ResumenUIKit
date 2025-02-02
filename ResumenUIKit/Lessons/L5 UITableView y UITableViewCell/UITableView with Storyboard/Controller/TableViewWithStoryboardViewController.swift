//
//  TableViewWithStoryboardViewController.swift
//  ResumenUIKit
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

class TableViewWithStoryboardViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private var allContentDataOfCells: [Any] = []
    
    // MARK: - LyfeCicle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fechAllData()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        configureTableView()
    }
    
}

// MARK: - UITableView methods and her delegates
extension TableViewWithStoryboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTypeOfCells()
        reloadTableViewData()
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func registerTypeOfCells() {
        // Registrar una celda hecha con un .xib (indicando el nombre del .xib, y el ID que se haya puesto en el Reuse Identifier de la protypeCell del storyboard
        tableView.register(UINib(nibName: "InfoMessageCell", bundle: nil), forCellReuseIdentifier: "InfoMessageCellID")
        
        // Regitrar una celda creada por código
        // tableView.register(ItemListCell.self, forCellReuseIdentifier: ListOfCellIDs.itemListCellID)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInThisSection = allContentDataOfCells.count
        return numberOfRowsInThisSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UITableView.automaticDimension
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < allContentDataOfCells.count {
            let item = allContentDataOfCells[indexPath.row]
            
            switch item {
            case let infoMessageVM as String:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoMessageCellID", for: indexPath) as? InfoMessageCell {
                    cell.configure(infoMessage: infoMessageVM)
                    return cell
                }
                
            default:
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
}

extension TableViewWithStoryboardViewController {
    
    private func fechAllData() {
        let firstHardcodedInfoMessage = "Primer mensaje de info (hardcoded)"
        allContentDataOfCells.append(firstHardcodedInfoMessage)
        let secondHardcodedInfoMessage = "Segundo mensaje de info (hardcoded)"
        allContentDataOfCells.append(secondHardcodedInfoMessage)
    }
    
}
