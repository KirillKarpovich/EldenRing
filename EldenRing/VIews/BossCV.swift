//
//  BossCV.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 13.01.23.
//

import UIKit

class BossCV: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    private let layout = UICollectionViewFlowLayout()
    private let itemsForRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)


   
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(
            BossCollectionViewCell.self,
            forCellWithReuseIdentifier: BossCollectionViewCell.identifier
        )
        self.backgroundColor = .gray
//        layout.estimatedItemSize = CGSize(width: 120, height: 120)
        layout.scrollDirection = .horizontal
        
        let paddingWidth = sectionInsets.left * (itemsForRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsForRow
        
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
    }
}

