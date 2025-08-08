import UIKit
import SnapKit

enum BirthError: Error {
    case rangeYear
    case rangeMonth
    case rangeDay
    case wrongInput
}

class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
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
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        textFieldGeneric(yearTextField)
        textFieldGeneric(monthTextField)
        textFieldGeneric(dayTextField)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
    
    
    func calculateDaysFromString(_ dateString: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        
        guard let date = formatter.date(from: dateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return components.day ?? 0
    }

    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        do {
            let _ = try validateInputValue()
            if let year = yearTextField.text ,
               let month = monthTextField.text,
               let day = dayTextField.text {
                
                let birthDay = "\(year)-\(month)-\(day)"
                if let daysPassed = calculateDaysFromString(birthDay) {
                    resultLabel.text = "오늘 날짜 기준으로 D+\(daysPassed) 일째 입니다."
                }
                
            }
        } catch {
            switch error {
            case .rangeYear:
                showAlert(tip: "정확한 년도를 입력해 주세요")
            case .rangeMonth:
                showAlert(tip: "정확한 월을 입력해 주세요")
            case .rangeDay:
                showAlert(tip: "정확한 일을 입력해 주세요")
            case .wrongInput:
                showAlert(tip: "입력값을 확인해 주세요")
            }
        }
    }
    
    private func validateInputValue() throws(BirthError) -> Bool {
        // 년
        if let yearValue = Int(yearTextField.text!) {
            
            guard 1925...2024 ~= yearValue else {
                throw .rangeYear
            }
            
        } else {
            throw .wrongInput
        }
        
        // 월
        if let monthValue = Int(monthTextField.text!) {
            guard 1...12 ~= monthValue else {
                throw .rangeMonth
            }
        } else {
            throw .wrongInput
        }
        
        // 일
        if let dayValue = Int(dayTextField.text!) {
            guard 1...31 ~= dayValue else {
                throw .rangeDay
            }
        } else {
            throw .wrongInput
        }
        
        return true
    }
}
