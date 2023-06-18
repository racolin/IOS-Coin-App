//
//  ViewController.swift
//  Coin App
//
//  Created by Administrator on 18/06/2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    //MARK: - Mapping UI component
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var viewCorner: UIView!
    
    //MARK: - Declare variable
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        
    }
    
    //MARK: - Init UI
    
    func initUI() {
        viewCorner.layer.cornerRadius = 28
        picker.dataSource = self
        picker.delegate = self
        coinManager.delegate = self
        
        // Set default index is 19
        picker.selectRow(19, inComponent: 0, animated: false)
        pickerView(picker, didSelectRow: 19, inComponent: 0)
    }
    
    //MARK: - Implement CoinManagerDelegate
    
    func onFetchError(_ error: String) {
        print(error)
    }
    
    func onFetchSuccess(_ model: CoinModel) {
        DispatchQueue.main.async {
            self.labelValue.text = model.getValueString()
        }
    }
    
    //MARK: - Implement UIPickerViewDelegate
    
    // return string value for row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.data[row]
    }
    
    // event 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelValue.text = "... \(coinManager.data[row])"
        coinManager.fetchDataCurrencyName(coinManager.data[row])
    }
    
    //MARK: - Implement UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.data.count
    }

    
}

