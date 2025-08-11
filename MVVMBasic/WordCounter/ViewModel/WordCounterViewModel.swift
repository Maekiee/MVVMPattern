import Foundation


class WordCounterViewModel {
    
    var updateCharacter: Observable<String> = Observable("")
    var outputText: Observable<String> = Observable("")
    
    init() {
        updateCharacter.bind { [weak self] value in
            guard let self = self else { return }
            updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        let count = updateCharacter.value.count
        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
