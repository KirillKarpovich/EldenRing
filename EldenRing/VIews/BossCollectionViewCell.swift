//
//  BossCollectionViewCell.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 13.01.23.
//

import UIKit

class BossCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: BossCollectionViewCell.self)
//    private let containerView = UIView()
    private let layout = UICollectionViewFlowLayout()
    let imageView = UIImageView()
    private let nameLabel = UILabel()
    let likeButton = UIButton()
    
    private var currentImageUrl: String?
    private var dataTask: URLSessionDataTask?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeButton)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        
       
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .highlighted)

        likeButton.contentMode = .scaleToFill
      
      
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
  
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        dataTask?.cancel()
    }
    
    
    func configure(with boss: Boss) {
        nameLabel.text = boss.name        
        
        
        if let cachedData = CacheManager.getPhotoCache(boss.image ?? "https://eldenring.fanapis.com/images/bosses/17f69b4ba0al0i1uk6s98t1nbtxunt.png") {
            self.imageView.image = UIImage(data: cachedData)
            return
        }
        
        let url = URL(string: boss.image ?? "https://eldenring.fanapis.com/images/bosses/17f69b4ba0al0i1uk6s98t1nbtxunt.png")
        
        if currentImageUrl == url?.absoluteString {
            return
        } else {
            currentImageUrl = url?.absoluteString
        }
        
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: url!) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, url?.absoluteString == self.currentImageUrl else { return }
            
            CacheManager.setPhotoCache(url!.absoluteString, data)
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
        dataTask?.resume()
    }

}





