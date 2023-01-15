//
//  BossCollectionViewCell.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 13.01.23.
//

import UIKit

class BossCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: BossCollectionViewCell.self)
    private let containerView = UIView()
    private let layout = UICollectionViewFlowLayout()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    
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
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        
        
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil 
    }
    
    
    func configure(with boss: Boss) {
        
        nameLabel.text = boss.name

        if let cachedData = CacheManager.getVideoCache(boss.image ?? "https://eldenring.fanapis.com/i mages/bosses/17f69b4ba0al0i1uk6s98t1nbtxunt.png") {
            
            imageView.image = UIImage(data: cachedData)
        }
        
        let url = URL(string: boss.image ?? "https://eldenring.fanapis.com/images/bosses/17f69b4ba0al0i1uk6s98t1nbtxunt.png")
        
        let session = URLSession.shared
        
        session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != boss.image {
                    return
                }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
