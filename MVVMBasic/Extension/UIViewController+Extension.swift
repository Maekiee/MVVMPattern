import UIKit

extension UIViewController {
    
    func showAlert(tip message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func customCornerGeneric<T: UIView>(_ view: T) {
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .systemPurple
    }
    
    func textFieldGeneric<T: UITextField>(_ view: T) {
        view.borderStyle = .roundedRect
    }
    
    
    func validateInputView<T, E: Error>(returnValue: T) throws(E) -> T {
        
        return returnValue
    }
    
}
