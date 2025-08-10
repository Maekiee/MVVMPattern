import UIKit
import SnapKit

class ProfileImageSettingViewController: UIViewController {
    let viewModel = ProfileImageSettingViewModel()
    var isSelectedImage: ((String) -> Void)?
    
    let imageList:[String] = [
        "profile_1",
        "profile_2",
        "profile_3",
        "profile_4",
        "profile_5",
        "profile_6",
        "profile_7",
        "profile_8",
        "profile_9",
        "profile_10",
        "profile_11",
        "profile_12",
    ]
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.borderColor = UIColor.completeButtonColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = setCellLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        return collectionView
    }()
    
    var imageNamed: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiraachy()
        configLayout()
        configView()
        
        
        guard let imageString = imageNamed else { return }
        viewModel.inputSelectedImage = imageString
        profileImage.image = UIImage(named: imageString)
        
        viewModel.closure = {
            guard let imageString = self.viewModel.inputSelectedImage else { return }
            self.profileImage.image = UIImage(named: imageString)
            self.collectionView.reloadData()
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }
    
    @objc func popButtonTapped() {
        guard let selectedImage = self.viewModel.inputSelectedImage else { return }
        isSelectedImage?(selectedImage)
        navigationController?.popViewController(animated: true)
    }
    
    
}


extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        let item = imageList[indexPath.item]
        cell.profileImage.image = UIImage(named: item)
        let isSelected = viewModel.inputSelectedImage == imageList[indexPath.item]
        cell.profileImageColor(isSelected: isSelected)
        
        return cell
    }
    
    func setCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - 64) / 4
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        layout.scrollDirection = .vertical
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageList[indexPath.item])
        viewModel.inputSelectedImage = imageList[indexPath.item]
    }
    
    
}


extension ProfileImageSettingViewController {
    private func configHeiraachy() {
        view.addSubview(profileImage)
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(60)
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
            
        }
        
    }
    
    private func configView() {
        view.backgroundColor = .white
        navigationItem.title = "IMAGE SETTING"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popButtonTapped))
        
    }
}
