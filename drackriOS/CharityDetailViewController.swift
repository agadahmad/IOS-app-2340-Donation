//
//  CharityDetailViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class CharityDetailViewController: UIViewController {
    
    static func initialize(charity: Charity) -> CharityDetailViewController {
        let charityDetailViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "charityDetail") as! CharityDetailViewController
        charityDetailViewController.charity = charity
        return charityDetailViewController
    }
    
    @IBOutlet weak var textView: UITextView!
    
    private var charity: Charity!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = charity.name
    
        textView.text = "\(charity.key)\n\(charity.name)\n\(charity.coordinate)\n\(charity.address)\n\(charity.city)\n\(charity.state)\n\(charity.zip)\n\(charity.type)\n\(charity.phoneNumber)\n\(charity.website)"
        
    }
    @IBAction func mapTapped(_ sender: Any) {
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        DonationSearch.searchCharity(charity: charity)
    }
    @IBAction func donationsTapped(_ sender: Any) {
        let vc = DonationsTableViewController.initialize(charity: charity)
        navigationController?.pushViewController(vc, animated: true)
    }
}
