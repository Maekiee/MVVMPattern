import Foundation


class AgeViewModel {
    
    var inputText:Observable<String> = Observable("")
    var outputText:Observable<String> = Observable("")
    
    init() {
        inputText.bind { [weak self] value in
            guard let self = self else { return }
            showResult()
        }
    }
    
    private func showResult() {
        do {
            let _ = try validateInputValue()
            self.outputText.value = "\(inputText.value)살 입니다."
        } catch ValidationAgeError.emptyValue {
            self.outputText.value = "값을 입력해 주세요"
        } catch ValidationAgeError.stringFailed {
            outputText.value = "숫자 값을 입력해 주세요"
        } catch ValidationAgeError.rangeAge {
            outputText.value = "1세 이상 100세 이하만 입력해주세요"
        } catch {
            outputText.value = "잠시후 다시 이용해 주세요"
        }
    }
    
    private func validateInputValue() throws -> Bool {
        guard !(inputText.value.isEmpty) else {
            throw ValidationAgeError.emptyValue
        }
        
        guard Int(inputText.value) != nil else {
            throw ValidationAgeError.stringFailed
        }
        
        guard 1...100 ~= (Int(inputText.value)!)  else {
            throw ValidationAgeError.rangeAge
        }
        
        return true
    }
}
