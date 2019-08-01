//
//  MailViewController.swift
//  AnimationBase
//
//  Created by Anan Sadiya on 29/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var undoBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var selectAllBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var trashBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var mailTableView: UITableView!
    
    var selectedMailsCount: Int = 0
    fileprivate var filteredMails = [DisplayMail]()
    fileprivate var isFiltering = false
    let searchController = UISearchController(searchResultsController: nil)
    
    var displayMails: [DisplayMail] = [
        DisplayMail(id: 1, title: "Hola", isItemSelected: false),
        DisplayMail(id: 2, title: "Salut", isItemSelected: false),
        DisplayMail(id: 3, title: "Hallo", isItemSelected: false),
        DisplayMail(id: 4, title: "Ciao", isItemSelected: false),
        DisplayMail(id: 5, title: "Ahoj", isItemSelected: false),
        DisplayMail(id: 6, title: "Yah sahs", isItemSelected: false),
        DisplayMail(id: 7, title: "Bog", isItemSelected: false),
        DisplayMail(id: 8, title: "Hei", isItemSelected: false),
        DisplayMail(id: 9, title: "Czesc", isItemSelected: false),
        DisplayMail(id: 10, title: "Ní hao", isItemSelected: false),
        DisplayMail(id: 11, title: "Shalom", isItemSelected: false),
        DisplayMail(id: 12, title: "Marhaba", isItemSelected: false),
        DisplayMail(id: 13, title: "Salam", isItemSelected: false),
        DisplayMail(id: 14, title: "Hujambo", isItemSelected: false),
        DisplayMail(id: 15, title: "Olá", isItemSelected: false),
        DisplayMail(id: 16, title: "Hey", isItemSelected: false),
        DisplayMail(id: 17, title: "Hi", isItemSelected: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search mails"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func updateUI() {
        titleNavigationItem.title = getTitle()
        trashBarButtonItem.isEnabled = getSelectedMailsCount() > 0
        undoBarButtonItem.isEnabled = getSelectedMailsCount() > 0
        selectAllBarButtonItem.isEnabled = getSelectedMailsCount() != displayMails.count
    }
    
    private func getTitle() -> String{
        if getSelectedMailsCount() == 0 {
            return "Entrada"
        } else {
            return "Selected: " + String(getSelectedMailsCount())
        }
    }
    
    private func getSelectedMailsCount() -> Int {
        return displayMails.filter({$0.isItemSelected}).count
    }
    
    @IBAction func deleteBarButtonItemTapped(_ sender: UIBarButtonItem) {
        if isFiltering {
            updateFiltered()
        }
        let indexPaths = generateIndexPathsFromMailSelectedItems(displayMails: isFiltering ? filteredMails : displayMails)
        deleteSelectedMailItems(indexPaths: indexPaths)
        updateUI()
    }
    
    @IBAction func selectAllBarButtonItemTapped(_ sender: UIBarButtonItem) {
        flipVisibleCells(from: false)
        updateMailSelectedItem(to: true)
        updateUI()
    }
    
    @IBAction func undoSelectedItemsTapped(_ sender: UIBarButtonItem) {
        flipVisibleCells(from: true)
        updateMailSelectedItem(to: false)
        updateUI()
    }
    
    private func generateIndexPathsFromMailSelectedItems(displayMails: [DisplayMail]) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for i in 0 ..< displayMails.count {
            if displayMails[i].isItemSelected {
                let indexPath = IndexPath(row: i, section: 0)
                indexPaths.append(indexPath)
            }
        }
        return indexPaths
    }
    
    private func updateFiltered() {
        for i in 0 ..< filteredMails.count {
            guard let displayMail = displayMails.filter({$0.id == filteredMails[i].id}).first else {
                return
            }
            filteredMails[i].isItemSelected = displayMail.isItemSelected
        }
    }
    
    private func deleteSelectedMailItems(indexPaths: [IndexPath]) {
        if isFiltering {
            filteredMails.removeAll(where: {$0.isItemSelected})
            displayMails.removeAll(where: {$0.isItemSelected})
        } else {
            displayMails.removeAll(where: {$0.isItemSelected})
        }
        
        mailTableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    private func flipVisibleCells(from selected: Bool) {
        var displayMails = self.displayMails
        displayMails = isFiltering ? filteredMails : displayMails
        
        for cell in mailTableView.visibleCells {
            guard let cell = cell as? MailCell else {
                return
            }
            
            let displayEmail = displayMails.filter({$0.id == cell.displayMail?.id}).first!
            
            if displayEmail.isItemSelected == selected {
                cell.flip(displayEmail: displayEmail)
            }
        }
    }
    
    private func updateMailSelectedItem(to selected: Bool) {
        if isFiltering {
            for i in 0 ..< filteredMails.count {
                if filteredMails[i].isItemSelected == !selected {
                    filteredMails[i].isItemSelected = !filteredMails[i].isItemSelected
                }
                for y in 0 ..< displayMails.count {
                    if displayMails[y].id == filteredMails[i].id {
                        displayMails[y].isItemSelected = filteredMails[i].isItemSelected
                    }
                }
            }
        } else {
            for i in 0 ..< displayMails.count {
                if displayMails[i].isItemSelected == !selected {
                    displayMails[i].isItemSelected = !displayMails[i].isItemSelected
                }
            }
        }
    }
}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredMails.count : displayMails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MailCell {
            let displayMail: DisplayMail
            if isFiltering {
                displayMail = filteredMails[indexPath.row]
            } else {
                displayMail = displayMails[indexPath.row]
            }
            cell.setup(displayMail: displayMail, mailTableViewCellDelegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MailViewController: MailTableViewCellDelegate {
    func changeMailStatus(displayEmail: DisplayMail) {
        for i in 0 ..< displayMails.count {
            if displayMails[i].id == displayEmail.id {
                displayMails[i].isItemSelected = displayEmail.isItemSelected
            }
        }
        
        updateUI()
    }
}

extension MailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            filteredMails = displayMails.filter({ (displayMail) -> Bool in
                return displayMail.title.lowercased().contains(text.lowercased())
            })
            isFiltering = true
        }
        else {
            isFiltering = false
            filteredMails = [DisplayMail]()
        }
        mailTableView.reloadData()
    }
}
