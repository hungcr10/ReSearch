import UIKit
class CoinViewController: UIViewController {
    @IBOutlet weak var currentcyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currentcyLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mainSlider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!
}

//MARK: -Life Cycle
extension CoinViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        currentcyPicker.dataSource = self
        currentcyPicker.delegate = self
        CoinManager.coinManger.delegate = self
    }
}
//MARK: - Action
extension CoinViewController {
    @IBAction func changeValueSlider(_ sender: Any) {
        let currentValue = Int(mainSlider.value)
        valueLabel.text = "\(currentValue)"
    }
}
//MARK: - CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currentcyLabel.text = currency
        }
    }
}

//MARK: - Datasource
extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CoinManager.coinManger.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CoinManager.coinManger.currencyArray[row] // drop down
    }
}

//MARK: - Delegate
extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let seclectCurrency = CoinManager.coinManger.currencyArray[row]
        CoinManager.coinManger.getCoinPrice(for: seclectCurrency)
    }
}
