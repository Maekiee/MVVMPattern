import Foundation


class ProfileImageSettingViewModel {
    var closure: (() -> Void)?
    
    var inputSelectedImage: String? {
        didSet {
            closure?()
        }
    }
        
}
