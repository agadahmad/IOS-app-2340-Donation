//
//  RegisterViewController.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typePicker.delegate = self
        typePicker.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AccountType.values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AccountType.values[row].name
    }

    @IBAction func keyboardDismissTapped(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func registerTapped(_ sender: Any) {
        UserAuthentication.register(email: emailField.text ?? "", name: nameField.text ?? "", password: passwordField.text ?? "", type: AccountType(rawValue: typePicker.selectedRow(inComponent: 0))!)
        dismiss(animated: true, completion: nil)
    }
}
