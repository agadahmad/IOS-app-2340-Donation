//
//  DonationSearch.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class DonationSearch {
    
    static func search(charity: Charity?, byType type: DonationType) -> [Donation] {
        return (charity?.donations ?? CharityDataProvider.charities.flatMap {
            $0.donations
        }).filter { $0.type == type }
    }
    
    static func search(charity: Charity?, byDescription description: String) -> [Donation] {
        return (charity?.donations ?? CharityDataProvider.charities.flatMap {
            $0.donations
        }).filter {
            $0.description.lowercased().contains(description.lowercased()) || description.lowercased().contains($0.description.lowercased())
        }
    }
    
    static func searchCharity(charity: Charity?) {
        let viewController = UIApplication.shared.keyWindow!.rootViewController!
        let alertController = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        let typeAction = UIAlertAction(title: "Type", style: .default) { _ in
            let typeAlertController = UIAlertController(title: "Search by Type", message: nil, preferredStyle: .actionSheet)
            let typesAsActions = DonationType.values.map { type in
                UIAlertAction(title: type.name, style: .default) { _ in
                    let results = DonationSearch.search(charity: charity, byType: type)
                    let vc = DonationSearchResultsTableViewController(donations: results)
                    viewController.show(vc, sender: nil)
                }
            }
            typesAsActions.forEach(typeAlertController.addAction)
            viewController.present(typeAlertController, animated: true, completion: nil)
        }
        let descriptionAction = UIAlertAction(title: "Description", style: .default) { _ in
            let descriptionAlertController = UIAlertController(title: "Description", message: nil, preferredStyle: .alert)
            descriptionAlertController.addTextField(configurationHandler: nil)
            let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
                let query = descriptionAlertController.textFields!.first!.text!
                let results = DonationSearch.search(charity: charity, byDescription: query)
                let vc = DonationSearchResultsTableViewController(donations: results)
                viewController.show(vc, sender: nil)
            }
            descriptionAlertController.addAction(searchAction)
            viewController.present(descriptionAlertController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(typeAction)
        alertController.addAction(descriptionAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
