import UIKit
import SnapKit


class CreateProfileViewController: UIViewController {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.borderColor = UIColor.completeButtonColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = false
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
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해 주세요"
        return textField
    }()
    
    let horizonDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let validateStateLabel: UILabel = {
        let label = UILabel()
        label.text = "teest label"
        return label
    }()
    
    let mbtiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.layer.cornerRadius = 22
        button.tintColor = .white
        button.backgroundColor = .disableButtonColor
        return button
    }()
    
    let EButton = UICircleButton(
        title: "E",
        backgroundColor: .white,
        titleColor: .gray
    )
    let IButton = UICircleButton(
        title: "I",
        backgroundColor: .white,
        titleColor: .gray
    )
    
    let horizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiraachy()
        configLayout()
        configView()
        
        [EButton, IButton].forEach { verticalStackView.addArrangedSubview($0)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
//        cameraIcon.layer.cornerRadius = cameraIcon.frame.height / 2
        
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
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
        
        view.addSubview(verticalStackView)
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
            make.top.equalTo(validateStateLabel.snp.bottom).offset(60)
            make.leading.leading.equalToSuperview().offset(20)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(validateStateLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(108)
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
        
    }
}
