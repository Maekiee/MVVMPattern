import Foundation


class WordCounterViewModel {
    var closure: (() -> Void)?
    
    var resultOutputText: String = "" {
        didSet {
            closure?()
        }
    }
    
    var updateCharacter: String = "" {
        didSet {
            updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        let count = updateCharacter.count
        resultOutputText = "현재까지 \(count)글자 작성중"
    }
}
