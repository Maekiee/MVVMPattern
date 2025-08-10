import UIKit
import SnapKit

enum MBTIType:String, CaseIterable {
    case E, S, T, J, I, N, F, P
    
    static var MBTIbtn: [UICircleButton] {
        
        MBTIType.allCases.map { item in
            return UICircleButton(
                title: item.rawValue,
            )
        }
    }
}

final class CreateProfileViewController: UIViewController {
    private let viewModel = CreateProfileViewModel()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.borderColor = UIColor.completeButtonColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiraachy()
        configLayout()
        configView()
        setMBTILayout()
        
        viewModel.closure = {
            self.validateStateLabel.text = self.viewModel.resultLabel
            self.validateStateLabel.textColor = self.viewModel.outputColor ? .allowedStateColor : .rejectStateColor
            self.profileImage.image = UIImage(named: self.viewModel.setImage)
        }
        
        viewModel.validateAllValue = {
            if self.viewModel.hasAllValue {
                self.completeButton.backgroundColor = .completeButtonColor
                self.completeButton.isUserInteractionEnabled = true
            } else {
                self.completeButton.backgroundColor = .disableButtonColor
                self.completeButton.isUserInteractionEnabled = false
            }
        }
        
        profileImage.image = UIImage(named: self.viewModel.setImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }
    
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
            button.tag = index
            viewModel.mbtiButtonDict[button.tag] = button
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
    
    
    @objc func selectedMBTI(_ sender: UICircleButton) {
        viewModel.selectedButtonTag = sender
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushTapped() {
        let vc = ProfileImageSettingViewController()
        vc.imageNamed = viewModel.setImage
        vc.isSelectedImage = { image in
            self.viewModel.setImage = image
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel.inputText = sender.text!
    }
    
    @objc func getStartButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        sceneDelegate.changeRootViewController()
    }
}

extension CreateProfileViewController {
    private func configHeiraachy() {
        view.addSubview(profileImage)
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
        completeButton.addTarget(self, action: #selector(getStartButtonTapped), for: .touchUpInside)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
}
