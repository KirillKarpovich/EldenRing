//
//  DetailViewController.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 15.01.23.
//

import UIKit

class DetailViewController: UIViewController {
    
    let nameLabel = UILabel()
    let imageViewDetail = UIImageView()
    let descriptionText = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        
        view.backgroundColor = .brown
        
        nameLabel.textAlignment = .center
        nameLabel.sizeToFit()
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewDetail.layer.cornerRadius = 20
        imageViewDetail.layer.borderWidth = 2
        imageViewDetail.layer.masksToBounds = true
        imageViewDetail.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.backgroundColor = .brown
        descriptionText.font = UIFont.systemFont(ofSize: 20)
        
        view.addSubview(imageViewDetail)
        view.addSubview(nameLabel)
        view.addSubview(descriptionText)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            imageViewDetail.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            imageViewDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageViewDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageViewDetail.heightAnchor.constraint(equalToConstant: 280)
        ])
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: imageViewDetail.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionText.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
