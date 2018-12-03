//
//  AddDonationViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class AddDonationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static func initialize(charity: Charity) -> UINavigationController {
        let addDonationNavigationController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(withIdentifier: "addDonation") as! UINavigationController
        (addDonationNavigationController.viewControllers.first! as! AddDonationViewController).charity = charity
        return addDonationNavigationController
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    
    private var charity: Charity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DonationType.values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DonationType.values[row].name
    }

    @IBAction func doneTapped(_ sender: Any) {
        let selectedTypeIndex = typePicker.selectedRow(inComponent: 0)
        let donation = Donation(
            date: datePicker.date,
            zip: zipField.text!,
            description: descriptionField.text!,
            amount: Double(amountField.text!)!,
            type: DonationType(rawValue: selectedTypeIndex)!
        )
        charity.donations.append(donation)
        CharityDataProvider.save()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func keyboardDismissTapped(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
