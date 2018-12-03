//
//  CharitiesTableViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class CharitiesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchTapped)),
            UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapTapped))
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        
    }
    
    var appeared = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !appeared {
            appeared = true
            let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! UINavigationController
            present(nc, animated: true, completion: nil)
        }
    }
    
    @objc func searchTapped() {
        DonationSearch.searchCharity(charity: nil)
    }
    
    @objc func mapTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        present(vc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharityDataProvider.charities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = CharityDataProvider.charities[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CharityDetailViewController.initialize(charity: CharityDataProvider.charities[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }

}
