import Foundation

class Observable<T> {
    private var action: ((T) -> Void)?
    
    var value:T {
        didSet {
            print("값 didSet", oldValue, value)
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping (T) -> Void) {
        action(value)
        self.action = action
    }
}
