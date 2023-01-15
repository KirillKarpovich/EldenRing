//
//  ViewController.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 13.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var bosses = [Boss]()
    let bossCV = BossCV()
    let bossLabel = UILabel()
    let titleLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.text = "Elden Ring"
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.titleView = titleLabel
        
//        title = "Elden ring"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.backgroundColor = .gray

        view.backgroundColor = .gray
        networkManager.getData(page: 1) { data in
            DispatchQueue.main.async { [weak self] in
                self?.bosses = data
                self?.bossCV.reloadData()
            }
        }
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        bossCV.dataSource = self
        bossCV.delegate = self
        
        bossLabel.text = "Main Bosses"
        bossLabel.translatesAutoresizingMaskIntoConstraints = false
        bossLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        bossLabel.sizeToFit()
        bossLabel.textAlignment = .center
       
        view.addSubview(bossCV)
        view.addSubview(bossLabel)
        
    }
}

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            bossCV.topAnchor.constraint(equalTo: bossLabel.bottomAnchor, constant: 20),
            bossCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bossCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bossCV.heightAnchor.constraint(equalToConstant: 180)
        ])
        NSLayoutConstraint.activate([
            bossLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bossLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bossLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bossLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bosses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BossCollectionViewCell.identifier, for: indexPath) as? BossCollectionViewCell else { fatalError("Unable to dequeue BossCell")
        }
        let boss = bosses[indexPath.row]
        
        cell.configure(with: boss)
        return cell        
    }
}
