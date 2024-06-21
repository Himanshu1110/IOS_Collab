//
//  MenuListVC.swift
//  IOS_Collob
//
//  Created by webcodegenie on 21/06/24.
//

import Foundation
import UIKit

class MenuListController: UITableViewController {
    
    var items = ["Help", "Settings", "Preferences", "Log Out"]
    var darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    //var delegatePop: MovetoScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row]
        content.textProperties.color = .white
        cell.contentConfiguration = content
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // Help
        } else if indexPath.row == 1 {
            // Settings
        } else if indexPath.row == 2 {
            // Preferences
        } else if indexPath.row == 3 {
            UserDefaults.standard.set(false, forKey: "IsUserLoggedIn")
            //delegatePop.MoveToPreviousScreen()
            
            NotificationCenter.default.post(name: NSNotification.Name("LogoutUser"), object: nil)
            // Log Out
            //logOut()
        }
        
    }
    
}
