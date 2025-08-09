import UIKit
import SnapKit

class CreateProfileViewController: UIViewController {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.borderColor = UIColor.completeButtonColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = false
        imageView.isUserInteractionEnabled = true
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
    let SButton = UICircleButton(
        title: "S",
        backgroundColor: .white,
        titleColor: .gray
    )
    let NButton = UICircleButton(
        title: "N",
        backgroundColor: .white,
        titleColor: .gray
    )
    let TButton = UICircleButton(
        title: "T",
        backgroundColor: .white,
        titleColor: .gray
    )
    let FButton = UICircleButton(
        title: "F",
        backgroundColor: .white,
        titleColor: .gray
    )
    let JButton = UICircleButton(
        title: "J",
        backgroundColor: .white,
        titleColor: .gray
    )
    let PButton = UICircleButton(
        title: "P",
        backgroundColor: .white,
        titleColor: .gray
    )
    let horizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let thirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let lastStackView: UIStackView = {
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
        
        [firstStackView, secondStackView, thirdStackView, lastStackView].forEach { horizonStackView.addArrangedSubview($0)}
        
        [EButton, IButton].forEach { firstStackView.addArrangedSubview($0) }
        [SButton, NButton].forEach { secondStackView.addArrangedSubview($0) }
        [TButton, FButton].forEach { thirdStackView.addArrangedSubview($0) }
        [JButton, PButton].forEach { lastStackView.addArrangedSubview($0) }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
//        cameraIcon.layer.cornerRadius = cameraIcon.frame.height / 2
        
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushTapped() {
        let vc = ProfileImageSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
        print(#function)
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
        
        view.addSubview(horizonStackView)
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
        
        horizonStackView.snp.makeConstraints { make in
            make.top.equalTo(validateStateLabel.snp.bottom).offset(60)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(224)
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushTapped))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
}
