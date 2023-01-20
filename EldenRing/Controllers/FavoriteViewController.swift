//
//  FavoriteViewController.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 16.01.23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let identifier = "FavTableViewCell"
    var favBosses = [Boss]()
    var tableView = UITableView()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.backgroundColor = .gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favBosses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavTableViewCell
        cell.textLabel?.text = favBosses[indexPath.row].name
        
        return cell
    }
}

extension FavoriteViewController: FavoritesDelegate {
    func removeItem(_ boss: Boss) {
        if let index = favBosses.firstIndex(of: boss) {
            favBosses.remove(at: index)
            tableView.reloadData()
        }
    }
        
    
   
    func appendItem(_ boss: Boss) {
        if !favBosses.contains(boss) {
            favBosses.append(boss)
            tableView.reloadData()
            print("append", boss)
        } else {
            print("boss already exists in favorites")
        }
    }
}


protocol FavoritesDelegate: AnyObject {
    func appendItem(_ boss: Boss)
    func removeItem(_ boss:Boss)
}
