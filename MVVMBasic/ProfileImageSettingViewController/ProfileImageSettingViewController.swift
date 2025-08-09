import UIKit

class ProfileImageSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiraachy()
        configLayout()
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}


extension ProfileImageSettingViewController {
    private func configHeiraachy() {
        
    }
    
    private func configLayout() {
        
    }
    
    private func configView() {
        view.backgroundColor = .white
        
        navigationItem.title = "IMAGE SETTING"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popButtonTapped))
        
    }
}
