//
//  ListViewController.swift
//  EventsVIPER
//
//  Created by Mokhles on 11.03.19.
//  Copyright © 2019 iostldr. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    var numberOfEvents: Int = 0
    var events: [Event]? = nil
    
    @IBOutlet weak var tableView: UITableView?

    let dataSource = ListDataSource()
    var presenter: ListPresenterInput? = nil
    
    //MARK: View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "App"
        presenter?.presenterOutput = self
        dataSource.delegate = self
        tableView?.dataSource = dataSource
        tableView?.prefetchDataSource = dataSource
        presenter?.loadEvents()
    }
    
}

// MARK: PRESENTER OUTPUT

extension ListViewController: ListPresenterOutput {
    
    func presentError(error: Error) {
        //TODO: resolve error messages and behavior according to code instead of technical error
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true, completion: nil)
    }
    
    func loadingStarted() {
        //TODO: useful method for tracking start of loading car details
    }
    
    func dataLoaded() {
        DispatchQueue.main.async { [weak self] in

            self?.tableView?.reloadData()
        }
    }
    
}

