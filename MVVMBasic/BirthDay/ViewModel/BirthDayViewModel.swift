import Foundation


enum BirthError: Error {
    case rangeYear
    case rangeMonth
    case rangeDay
    case wrongInput
}

class BirthDayViewModel {
    
    var inputTapped: Observable<[String]> = Observable([])
    var outputResultText: Observable<String> = Observable("")
    
    init() {
        inputTapped.bind { [weak self] value in
            guard let self = self else { return }
            caculateBirthDay()
        }
    }
    
    private func calculateDaysFromString(_ dateString: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        
        guard let date = formatter.date(from: dateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return components.day ?? 0
    }
    
    private func caculateBirthDay() {
        do {
            let _ = try validateInputValue()
            
            if !inputTapped.value.isEmpty {
                let year = inputTapped.value[0]
                let month =  inputTapped.value[1]
                let day =  inputTapped.value[2]
                let birthDay = "\(year)-\(month)-\(day)"
                
                if let daysPassed = calculateDaysFromString(birthDay) {
                    outputResultText.value = "오늘 날짜 기준으로 D+\(daysPassed) 일째 입니다."
                }
            }
            
        } catch {
            switch error {
            case .rangeYear:
                outputResultText.value = "정확한 년도를 입력해 주세요"
            case .rangeMonth:
                outputResultText.value = "정확한 월을 입력해 주세요"
            case .rangeDay:
                outputResultText.value = "정확한 일을 입력해 주세요"
            case .wrongInput:
                outputResultText.value = "입력값을 확인해 주세요"
            }
        }
    }
    
    private func validateInputValue() throws(BirthError) -> Bool {
        
        if !inputTapped.value.isEmpty {
            // 년
            if let yearValue = Int(inputTapped.value[0]) {
                
                guard 1925...2024 ~= yearValue else {
                    throw .rangeYear
                }
                
            } else {
                throw .wrongInput
            }
            
            // 월
            if let monthValue = Int(inputTapped.value[1]) {
                guard 1...12 ~= monthValue else {
                    throw .rangeMonth
                }
            } else {
                throw .wrongInput
            }
            
            // 일
            if let dayValue = Int(inputTapped.value[2]) {
                guard 1...31 ~= dayValue else {
                    throw .rangeDay
                }
            } else {
                throw .wrongInput
            }
        }
       
        return true
    }
    
}
