import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "ProfileImageCollectionViewCell"
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(72)
        }
        
        DispatchQueue.main.async {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func profileImageColor(isSelected: Bool) {
        if isSelected {
            profileImage.layer.borderColor = UIColor.completeButtonColor.cgColor
            profileImage.layer.borderWidth = 4
        } else {
            profileImage.layer.borderColor = UIColor.disableButtonColor.cgColor
            profileImage.layer.borderWidth = 2
        }
    }
}
