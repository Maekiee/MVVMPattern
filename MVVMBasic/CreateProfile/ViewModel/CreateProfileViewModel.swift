import Foundation

enum UserNameError: Error {

    case empty
    case range
    case wrongInput
    case number
}


class CreateProfileViewModel {
    var closure: (() -> Void)?
    
    var resultLabel: String = "" {
        didSet {
            closure?()
        }
    }
    
    var outputColor: Bool = false {
        didSet {
            closure?()
        }
    }
    
    var inputText: String? = "" {
        didSet {
            checkUserName()
        }
    }
    
    private func checkUserName() {
        do {
            let _ = try validateUserName()
            resultLabel = "사용할 수 있는 닉네임이에요"
            outputColor = true
        } catch {
            switch error {
            case .empty:
                outputColor = false
                resultLabel = ""
            case .range:
                outputColor = false
                resultLabel = "2글자 이상 10글자 미만으로 설정해주세요"
            case .wrongInput:
                outputColor = false
                resultLabel = "“닉네임에 @, #, $, % 는 포함할 수 없어요"
            case .number:
                outputColor = false
                resultLabel = "닉네임에 숫자는 포함할 수 없어요 "
            }
        }
    }
    
    private func validateUserName() throws(UserNameError) -> String {
        let forbiddenChars = CharacterSet(charactersIn: "@#$%")
        
        guard let text = inputText else {
            print("엠티 에러")
            throw .empty
        }
        
        guard text.count != 0 else {
            throw .empty
        }
        
        guard text.count > 0 && text.count >= 2 && text.count < 10 else {
            print("카운터 에러")
            throw .range
        }
        
//        카운트가 2 초과 10 이하 이지 않으면 에러
        
        guard text.rangeOfCharacter(from: .decimalDigits) == nil else {
            print("숫자 에러")
            throw .number
        }
        
        guard text.rangeOfCharacter(from: forbiddenChars) == nil else {
            print("특수묹 에러")
            throw .wrongInput
        }
        
        return text
    }
    
    
}
