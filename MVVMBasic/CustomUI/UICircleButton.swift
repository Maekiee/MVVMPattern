import UIKit


class UICircleButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.title = title
        config.titleAlignment = .center
        config.attributedTitle?.font = .systemFont(ofSize: 14, weight: .semibold)
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .gray
        config.background.strokeColor = .gray
        config.background.strokeWidth = 1
        config.background.cornerRadius = 25
        self.configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
