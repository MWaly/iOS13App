//
//  ListDatasource.swift
//  EventsVIPER
//
//  Created by Mokhles on 11.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import Foundation
import UIKit

final class ListDataSource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {

    weak var delegate: ListPresenterOutput? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing:  ListItemTableViewCell.self), for: indexPath) as! ListItemTableViewCell
        guard let event = delegate?.events?[indexPath.row]
            else { return cell }
        cell.eventDate?.text = event.localDate + event.localTime
        cell.eventName?.text = event.name
        cell.meetupGroupName?.text = event.groupName
        cell.peopleRSVPED?.text = String(event.yesRsvpCount)
        
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}


