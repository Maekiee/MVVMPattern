import Foundation

enum UserNameError: Error {

    case empty
    case range
    case wrongInput
    case number
}


// 이미지, 엠비티아이, 닉네임 값이 모두 있으면 true 하나라도 없으면 falseㅅ
class CreateProfileViewModel {
    var closure: (() -> Void)?
    
    var setImage: String = "profile_12" {
        didSet {
            closure?()
        }
    }
    
    // 닉네임 결과 상태
    var resultLabel: String = "" {
        didSet {
            closure?()
        }
    }
    
    // 닉네임 값 받기
    var inputText: String? = "" {
        didSet {
            checkUserName()
        }
    }
    
    // 상태 레이블 컬러 변경
    var outputColor: Bool = false {
        didSet {
            closure?()
        }
    }
    
    // 클릭한 버튼 변경
    var selectedButtonTag: UICircleButton? {
        didSet {
            changeButtonColor()
        }
    }
    
    // 버튼과 테그 값 받아오는곳
    var mbtiButtonDict: [Int: UICircleButton] = [:]
    
    
    private func changeButtonColor() {
        guard let button = selectedButtonTag else { return }
        let pairButtonTag = button.tag < 4 ? button.tag + 4 : button.tag - 4
        
        if let pairButton = mbtiButtonDict[pairButtonTag] {
            if pairButton.isSelected {
                pairButton.isSelected = false
            }
        }
        
        selectedButtonTag?.isSelected.toggle()
        
    }
    
    private func checkUserName() {
        do {
            let userName = try validateUserName()
            resultLabel = "사용할 수 있는 닉네임이에요"
            outputColor = true
            print(userName)
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
