import UIKit
import SnapKit


class OnboardingViewController: UIViewController {
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.layer.cornerRadius = 22
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startButton)
        view.backgroundColor = .white
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(48)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        startButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
    
    @objc func buttonTapped() {
        let vc = CreateProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

