//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Jordan White on 9/4/25.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ConversionViewController loaded its view.")
        textField.delegate = self
    }
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            let formatter = NumberFormatter()
                   formatter.numberStyle = .decimal
                   formatter.maximumFractionDigits = 1
                   formatter.minimumFractionDigits = 1
                   celsiusLabel.text = formatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {

        if string.isEmpty { return true }

        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
           
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return false
        }

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        let decimalSeparator = "."
        let decimalCount = updatedText.components(separatedBy: decimalSeparator).count - 1
        if decimalCount > 1 {
            return false
        }

        if let dotIndex = updatedText.firstIndex(of: ".") {
            let decimals = updatedText[updatedText.index(after: dotIndex)...]
            if decimals.count > 1 {
                return false
            }
        }

        return true
    }


}

