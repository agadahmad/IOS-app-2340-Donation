//
//  DonationDetailViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class DonationDetailViewController: UIViewController {
    
    static func initialize(donation: Donation) -> DonationDetailViewController {
        let donationDetailViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "donationDetail") as! DonationDetailViewController
        donationDetailViewController.donation = donation
        return donationDetailViewController
    }
    
    @IBOutlet weak var textView: UITextView!
    
    private var donation: Donation!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = donation.description
        
        textView.text = "\(donation.date)\n\(donation.zip)\n\(donation.description)\n\(donation.amount)\n\(donation.type.name)"
        
    }

}
