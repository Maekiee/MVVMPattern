import UIKit

enum BMIValidationError: Error {
    case emptyValue
    case stringFailed
    case rangeHeight
    case rangeWeight
}

class BMIViewController: UIViewController {
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
        customCornerGeneric(resultButton)
        textFieldGeneric(heightTextField)
        textFieldGeneric(weightTextField)
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let _ = try validateInputValue()
        } catch {
            switch error {
            case .emptyValue:
                showAlert(tip: "값을 입력해주세요")
            case .stringFailed:
                showAlert(tip: "유효한 값을 입력해 주세요")
            case .rangeHeight:
                showAlert(tip: "정확한 키를 입력해주세요")
            case .rangeWeight:
                showAlert(tip: "정확한 몸무게를 입력해주세요")
            }
        }
    }
    
    private func validateInputValue() throws(BMIValidationError) -> Bool {
        
        guard !(heightTextField.text!.isEmpty) || !(weightTextField.text!.isEmpty) else {
            throw .emptyValue
        }
        
        guard let weightDouble = Double(weightTextField.text!), let heightDouble = Double(heightTextField.text!) else {
            throw .emptyValue
        }
        
        guard Double(heightTextField.text!) != nil || Double(weightTextField.text!) != nil else {
            throw .stringFailed
        }
        
        guard 100.0...200.0 ~= heightDouble else {
            throw .rangeHeight
        }
        
        guard 30.0...200.0 ~= weightDouble  else {
            throw .rangeWeight
        }
        
        return true
    }
}
