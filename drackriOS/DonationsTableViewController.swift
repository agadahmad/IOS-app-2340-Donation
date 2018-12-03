//
//  DonationsTableViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class DonationsTableViewController: UITableViewController {
    
    static func initialize(charity: Charity) -> DonationsTableViewController {
        let donationsTableViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "donations") as! DonationsTableViewController
        donationsTableViewController.charity = charity
        return donationsTableViewController
    }
    
    private var charity: Charity!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charity.donations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = charity.donations[indexPath.row].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DonationDetailViewController.initialize(donation: charity.donations[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func addTapped(_ sender: Any) {
        guard UserAuthentication.signedInUser?.type != AccountType.user else {
            return
        }
        let vc = AddDonationViewController.initialize(charity: charity)
        present(vc, animated: true, completion: nil)
    }
}
