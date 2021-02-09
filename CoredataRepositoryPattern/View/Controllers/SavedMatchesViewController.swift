//
//  SavedMatchesViewController.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 08/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class SavedMatchesViewController: UIViewController {

    @IBOutlet weak var savedMatchesTableView: UITableView!
    
    private var savedMatchesViewModel = SavedMatchesViewModel()
    var venueArray = [Venue]()
    weak var delegate : RefreshPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpTableView()
        fetchSavedMatches()
    }
    
    func setUpTableView(){
        
        savedMatchesTableView.delegate = self
        savedMatchesTableView.dataSource = self
        savedMatchesTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        savedMatchesTableView.estimatedRowHeight = 100
        savedMatchesTableView.rowHeight = UITableView.automaticDimension
        
        savedMatchesTableView.register(UINib(nibName: "AllMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMatchesTableViewCell")
    }
    
    func fetchSavedMatches(){
        venueArray.removeAll()
        let result = savedMatchesViewModel.getSavedMAtchesList()!
        for t in result{
            let venu = Venue(id: t.matchId, name: t.matchName)
            venueArray.append(venu)
        }
        self.savedMatchesTableView.reloadData()
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.refreshPage()
    }
    
}

extension SavedMatchesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMatchesTableViewCell", for: indexPath) as! AllMatchesTableViewCell
        
        let matchData = venueArray[indexPath.row]
        cell.lblMatchName.text = matchData.name!
        cell.lblMatchId.text = "Match ID : \(matchData.id!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let matchVenu = venueArray[indexPath.row]
        
        savedMatchesViewModel.createMatch(match: matchVenu)
        
        fetchSavedMatches()
    }
    
}

protocol RefreshPageProtocol: class {
    func refreshPage()
}
