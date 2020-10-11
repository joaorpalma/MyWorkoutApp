//
//  ProfileDataSource.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class ProfileDataSource: NSObject, UITableViewDataSource {
    var profileDetails: [ProfileDetail] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        guard let detail = profileDetails[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = detail.getDescription()
        cell.detailTextLabel?.text = detail.getValue()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileDetails.count
    }
}
