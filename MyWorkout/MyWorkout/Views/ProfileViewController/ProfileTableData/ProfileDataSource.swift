//
//  ProfileDataSource.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

class ProfileDataSource: NSObject, UITableViewDataSource {
    private let _cellIdentifier = "cell"
    
    var profileDetails: [ProfileDetail] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: _cellIdentifier)
        cell ??= UITableViewCell(style: .value1, reuseIdentifier: _cellIdentifier)
        
        let item = profileDetails[safe: indexPath.row]
        
        guard let detail = item else { return UITableViewCell() }
        
        cell!.textLabel?.text = detail.getDescription()
        cell!.detailTextLabel?.text = detail.getValue()
        cell!.selectionStyle = .none
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileDetails.count
    }
}
