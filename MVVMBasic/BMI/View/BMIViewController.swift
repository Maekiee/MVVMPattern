import UIKit

enum BMIValidationError: Error {
    case emptyValue
    case stringFailed
    case rangeHeight
    case rangeWeight
}

class BMIViewController: UIViewController {
    let viewModel = BMIViewModel()
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("클릭", for: .normal)
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configView()
        
        viewModel.outputResultText.bind { [weak self] value in
            self?.resultLabel.text = value
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        viewModel.inputHeightText.value = heightTextField.text!
        viewModel.inputWeightText.value = weightTextField.text!
    }
}


extension BMIViewController {
    private func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    private func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    private func configView() {
        customCornerGeneric(resultButton)
        textFieldGeneric(heightTextField)
        textFieldGeneric(weightTextField)
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
}
