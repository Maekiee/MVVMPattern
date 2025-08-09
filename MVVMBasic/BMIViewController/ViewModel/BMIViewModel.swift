import Foundation


class BMIViewModel {
    var closureText: (() -> Void)?
    var closureAlert: (() -> Void)?
    
    var heightInputText: String? = nil {
        didSet {
            calculateBMI()
        }
    }
    
    var weightInputText: String? = nil {
        didSet {
            calculateBMI()
        }
    }
    
    var resultOutputText: String = "" {
        didSet {
            closureText?()
        }
    }
    
//    var alertMessage: String = "" {
//        didSet {
//            closureAlert?()
//        }
//    }
    
    private func calculateBMI() {
        do {
            let _ = try validateInputValue()
            if let height = Double(heightInputText!),
               let weight = Double(weightInputText!) {
                let DoubleHeight = height / 100
                let result = weight / (DoubleHeight * DoubleHeight)
                resultOutputText = String(format: "%.2f", result)
            }
            
        } catch {
            switch error {
            case .emptyValue:
                resultOutputText = "값을 입력해주세요"
                print("엠티 에러 실행")
            case .stringFailed:
                resultOutputText = "유효한 값을 입력해 주세요"
                print("문자열 에러 실앻")
            case .rangeHeight:
                resultOutputText = "정확한 키를 입력해 주세요"
                print("키 입력값 에러 실행")
            case .rangeWeight:
                resultOutputText = "정확한 몸무게를 입력해주세요"
                print("몸무게 입력값 에러 실행")
            }
        }
    }
    
    private func validateInputValue() throws(BMIValidationError) -> Bool {
        
        guard let heightText = heightInputText, let weightText = weightInputText else {
            throw .emptyValue
        }
        
        guard !heightText.isEmpty && !weightText.isEmpty else {
            throw .emptyValue
        }
        
        guard let heightDouble = Double(heightText), let weightDouble = Double(weightText) else {
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
