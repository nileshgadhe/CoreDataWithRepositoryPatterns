//
//  AllMatchesViewController.swift
//  CoredataRepositoryPattern
//
//  Created by Nilesh Gadhe on 04/02/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class AllMatchesViewController: UIViewController, RefreshPageProtocol{
    
    

    @IBOutlet weak var allMatchesTableView: UITableView!
        
    private var allMatchesViewModel = AllMatchesViewModel()
    
    var venueArray = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        getAllMatches()
    }
    
    func refreshPage() {
        getAllMatches()
    }
    
    func setUpTableView(){
        
        allMatchesTableView.delegate = self
        allMatchesTableView.dataSource = self
        allMatchesTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        allMatchesTableView.estimatedRowHeight = 100
        allMatchesTableView.rowHeight = UITableView.automaticDimension
        
        allMatchesTableView.register(UINib(nibName: "AllMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMatchesTableViewCell")
        
    }
    
    
    func getAllMatches(){
        
        allMatchesViewModel.getAllMatches{ (responseData) in
            self.venueArray.removeAll()
            print(responseData.response.venues)
            self.venueArray = responseData.response.venues
        
            DispatchQueue.main.async {
                self.allMatchesTableView.reloadData()
            }
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SavedMatchesViewController") as! SavedMatchesViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension AllMatchesViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        
        if allMatchesViewModel.recordExistInDatabaseOrNot(byId: matchData.id!){
            cell.imageViewStar.image = #imageLiteral(resourceName: "ic_filled_star")
        } else{
            cell.imageViewStar.image = #imageLiteral(resourceName: "ic_empty_star")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let matchVenu = venueArray[indexPath.row]
        
        allMatchesViewModel.createMatch(match: matchVenu)
        
        self.allMatchesTableView.reloadData()
    }
    
}
