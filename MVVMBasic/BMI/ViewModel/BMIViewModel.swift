import Foundation


class BMIViewModel {
    
    var inputHeightText:Observable<String> = Observable("")
    var inputWeightText:Observable<String> = Observable("")
    var outputResultText: Observable<String> = Observable("")
    
    init() {
        inputHeightText.bind { [weak self] value in
            guard let self = self else { return }
            calculateBMI()
        }
        
        inputWeightText.bind { [weak self] value in
            guard let self = self else { return }
            calculateBMI()
        }
    }
    
    private func calculateBMI() {
        do {
            let _ = try validateInputValue()
            if let height = Double(inputHeightText.value),
               let weight = Double(inputWeightText.value) {
                let DoubleHeight = height / 100
                let result = weight / (DoubleHeight * DoubleHeight)
                outputResultText.value = String(format: "%.2f", result)
            }
            
        } catch {
            switch error {
            case .emptyValue:
                outputResultText.value = "값을 입력해주세요@@"
            case .stringFailed:
                outputResultText.value = "유효한 값을 입력해 주세요"
            case .rangeHeight:
                outputResultText.value = "정확한 키를 입력해 주세요"
            case .rangeWeight:
                outputResultText.value = "정확한 몸무게를 입력해주세요"
            }
        }
    }
    
    private func validateInputValue() throws(BMIValidationError) -> Bool {
        
        guard !inputHeightText.value.isEmpty && !inputWeightText.value .isEmpty else {
            throw .emptyValue
        }
        
        guard let heightDouble = Double(inputHeightText.value), let weightDouble = Double(inputWeightText.value) else {
            throw .stringFailed
        }
        
        guard 100.0...250.0 ~= heightDouble else {
            throw .rangeHeight
        }
        
        guard 30.0...300.0 ~= weightDouble else {
            throw .rangeWeight
        }
        
        return true
    }
}
