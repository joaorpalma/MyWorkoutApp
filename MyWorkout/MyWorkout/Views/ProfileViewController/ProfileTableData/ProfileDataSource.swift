//
//  ProfileDataSource.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class ProfileDataSource: NSObject, UITableViewDataSource {
    private let _profileDetails: [ProfileDetail]
    
    init(profileDetails: [ProfileDetail]) {
        _profileDetails = profileDetails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        guard let detail = _profileDetails[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = detail.getDescription()
        cell.detailTextLabel?.text = detail.getValue()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _profileDetails.count
    }
}
