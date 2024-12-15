//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var currentSelected: UIButton?
    var tipBrain: TipBrain?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true
        )
        resetSelectedPercentage()
        sender.isSelected = true
        currentSelected = sender
    }
    
    func resetSelectedPercentage() -> Void {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print("Current: \(currentSelected?.currentTitle ?? "0")")
        let rawValue: String? = tipBrain?.getTipRawValue(value: currentSelected)
        
        if let val = rawValue {
            tipBrain?.getTipDecimalValue(value: val)
            let total: Float = Float(billTextField.text!) ?? 0.0
            tipBrain?.calculateResult(total: total, numberOfPeople: Float(splitNumberLabel.text!) ?? 0.0)
            
            print("Number of people: \(Float(splitNumberLabel.text!)!)")
            print("splitting result: \(tipBrain?.result ?? 0.0)")
            performSegue(withIdentifier: "goToResult", sender: self)
        }
        
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print("changed value: \(sender.value)")
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSelected = tenPctButton
        tipBrain = TipBrain()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.total = String(tipBrain?.result ?? 0.0)
            resultVC.settings = "Split between \(Int(tipBrain?.numberOfPeople ?? 0)) people, with \(tipBrain?.tipRawValue! ?? "0.0")% tip"
        }
    }
    
    
}

