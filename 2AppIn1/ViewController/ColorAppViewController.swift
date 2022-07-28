//
//  ViewController.swift
//  2AppIn1
//
//  Created by Алексей Гайдуков on 27.07.2022.
//

import UIKit

class ColorAppViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLable: UILabel!
    @IBOutlet var greenLable: UILabel!
    @IBOutlet var blueLable: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    //MARK: Pablic Properties
    var delegate: ColorAppViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorView.backgroundColor = viewColor
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLable, greenLable, blueLable)
        setValue(for: redTextField, greenTextField, blueTextField)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLable)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLable)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLable)
            setValue(for: blueTextField)
        
        }
        setColor()
            
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

//MARK: Private Methods
extension ColorAppViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat (redSlider.value),
            green: CGFloat (greenSlider.value),
            blue: CGFloat (blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for lables: UILabel...) {
        lables.forEach { lable in
            switch lable {
            case redLable: redLable.text = string(from: redSlider)
            case greenLable: greenLable.text = string(from: greenSlider)
            default: lable.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorSlider: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSlider.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: slider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "2.%f", slider.value)
    }
    
    @objc private func didTappedDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: UITextFieldDelegate
extension ColorAppViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLable)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLable)
            default: blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLable)
            }
            
            setColor()
            return
        }
        showAlert(title: "Wrog Format!", messege: "Please enter correct valur")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyBoardToolBar = UIToolbar()
        keyBoardToolBar.sizeToFit()
        textField.inputAccessoryView = keyBoardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTappedDone)
        )
        let flexBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyBoardToolBar.items = [flexBarButtonItem, doneButton]
    }
}
