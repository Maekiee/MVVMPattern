import Foundation


class AgeViewModel {
    
    var closureText: (() -> Void)?
    
    // 뷰에서 뷰모델로 들어오는 정보
    var ageInputField: String = "" {
        didSet {
            closureText?()
            showResult()
        }
    }
    
    // 뷰모델에서 뷰에게 전달할 정보
    var ageOutputText = "" {
        didSet {
            closureText?()
        }
    }
    
    private func showResult() {
        do {
            let _ = try validateInputValue()
            self.ageOutputText = "\(ageInputField)살 입니다."
        } catch ValidationAgeError.emptyValue {
            self.ageOutputText = "값을 입력해 주세요"
        } catch ValidationAgeError.stringFailed {
            ageOutputText = "숫자 값을 입력해 주세요"
        } catch ValidationAgeError.rangeAge {
            ageOutputText = "1세 이상 100세 이하만 입력해주세요"
        } catch {
            ageOutputText = "잠시후 다시 이용해 주세요"
        }
    }
    
    
    
    private func validateInputValue() throws -> Bool {
        
        guard !(ageInputField.isEmpty) else {
            throw ValidationAgeError.emptyValue
        }
        
        guard Int(ageInputField) != nil else {
            throw ValidationAgeError.stringFailed
        }
        
        guard 1...100 ~= (Int(ageInputField)!)  else {
            throw ValidationAgeError.rangeAge
        }
        
        return true
    }
}
