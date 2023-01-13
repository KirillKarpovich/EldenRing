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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        networkManager.getData(page: 1) { data in
            DispatchQueue.main.async { [weak self] in
                self?.bosses = data
                print(self!.bosses[1].description)
                
            }
        }
    }
}

