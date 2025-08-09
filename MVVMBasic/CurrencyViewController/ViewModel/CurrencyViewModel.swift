import Foundation


class CurrencyViewModel {
    var closure: (() -> Void)?
    
    var resultOutput: String = "" {
        didSet {
            closure?()
        }
    }
    
    var convertButtonTapped: String? =  ""{
        didSet {
            convertCurrency()
        }
    }
    
    private func convertCurrency() {
        guard let amountText = convertButtonTapped,
              let amount = Double(amountText) else {
            resultOutput = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        resultOutput = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
    
}
