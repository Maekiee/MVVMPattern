import Foundation


class CurrencyViewModel {
    
    var outputResultText: Observable<String> = Observable("")
    var covertButtonClicked: Observable<String> = Observable("")
    
    init() {
        covertButtonClicked.bind { [weak self] value in
            guard let self = self else { return }
            convertCurrency()
        }
    }
    
    
    private func convertCurrency() {

        
        if covertButtonClicked.value != "" {
            guard let amount = Double(covertButtonClicked.value) else {
                outputResultText.value = "올바른 금액을 입력해주세요"
                return
            }
            
            let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
            let convertedAmount = amount / exchangeRate
            outputResultText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        } else {
            outputResultText.value = "올바른 금액을 입력해주세요"
        }
        
       
    }
    
}
