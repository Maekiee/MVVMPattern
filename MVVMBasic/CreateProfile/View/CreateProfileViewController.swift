import UIKit
import SnapKit

enum MBTIType:String, CaseIterable {
    case E, I, S, N, T, F, J, P
    
    static var MBTIbtn: [UICircleButton] {
       
        MBTIType.allCases.map { item in
           return UICircleButton(
               title: item.rawValue,
           )
       }
    }
}

class CreateProfileViewController: UIViewController {
    let viewModel = CreateProfileViewModel()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.borderColor = UIColor.completeButtonColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "profile_12")
        return imageView
    }()
//    let cameraIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "camera.fill")
//        imageView.tintColor = .white
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .completeButtonColor
//        return imageView
//    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해 주세요"
        return textField
    }()
    private let horizonDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let validateStateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let mbtiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.layer.cornerRadius = 22
        button.tintColor = .white
        button.backgroundColor = .disableButtonColor
        return button
    }()
  
    
    private func setMBTILayout() {
        let mbtiButtons = MBTIType.MBTIbtn
        
        let contianerStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.distribution = .fillEqually
            return stackView
        }()
        let rowTopStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fillEqually
            return stackView
        }()
        let rowBottomStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fillEqually
            return stackView
        }()
        
        mbtiButtons.enumerated().forEach { (index, button) in
            button.addTarget(self, action: #selector(selectedMBTI), for: .touchUpInside)
            
            if index < 4 {
                rowTopStackView.addArrangedSubview(button)
            } else {
                rowBottomStackView.addArrangedSubview(button)
            }
        }
        
        [rowTopStackView, rowBottomStackView].forEach { contianerStackView.addArrangedSubview($0)
        }
        
        view.addSubview(contianerStackView)
        
        contianerStackView.snp.makeConstraints { make in
            make.top.equalTo(horizonDivider.snp.bottom).offset(72)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(224)
            make.height.equalTo(108)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiraachy()
        configLayout()
        configView()
        setMBTILayout()
    
        viewModel.closure = {
            self.validateStateLabel.text = self.viewModel.resultLabel
            self.validateStateLabel.textColor = self.viewModel.outputColor ? .allowedStateColor : .rejectStateColor
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
//        cameraIcon.layer.cornerRadius = cameraIcon.frame.height / 2
        
    }
    
    @objc func selectedMBTI(_ sender: UICircleButton) {
        var config = sender.configuration
        config?.baseBackgroundColor = .systemBlue
        config?.baseForegroundColor = .white
        config?.background.strokeWidth = 0
        sender.configuration = config
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushTapped() {
        let vc = ProfileImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel.inputText = sender.text!
    }
}

extension CreateProfileViewController {
    private func configHeiraachy() {
        view.addSubview(profileImage)
//        profileImage.addSubview(cameraIcon)
        view.addSubview(completeButton)
        view.addSubview(textField)
        view.addSubview(horizonDivider)
        view.addSubview(validateStateLabel)
        view.addSubview(mbtiTitleLabel)
        
    }
    
    private func configLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
//        cameraIcon.snp.makeConstraints { make in
//            make.size.equalTo(28)
//            make.trailing.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().offset(-8)
//        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        horizonDivider.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    
        validateStateLabel.snp.makeConstraints { make in
            make.top.equalTo(horizonDivider.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
         
        mbtiTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizonDivider.snp.bottom).offset(72)
            make.leading.leading.equalToSuperview().offset(20)
        }
        
        completeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(44)
        }
        
    }
    
    private func configView() {
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popButtonTapped))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushTapped))
        profileImage.addGestureRecognizer(tapGesture)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
}
