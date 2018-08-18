//
//  ViewController.swift
//  Project 02 Facebook
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let user = User.init(name: "Chris", photo: "profile", educationName: "CUHK")
    var isExpanded = false
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(SelectionRowKeys.allSections[indexPath.section].child(isExpanded: isExpanded)[indexPath.row].rowHeight())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        switch SelectionRowKeys.allSections[indexPath.section].child(isExpanded: isExpanded)[indexPath.row] {
        case .logOut:
            let alert = UIAlertController(title: "Log Out", message: "Are you sure to log out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .seeMore:
            isExpanded = !isExpanded
            if isExpanded{
                tableView.performBatchUpdates({
                    tableView.insertRows(at: [indexPath, IndexPath(row: indexPath.row+1, section: indexPath.section), IndexPath(row: indexPath.row+2, section: indexPath.section)], with: .top)
                    tableView.reloadRows(at: [IndexPath(item: indexPath.item, section: indexPath.section)], with: .automatic)
                }, completion: nil)
            } else {
                tableView.performBatchUpdates({
                    tableView.reloadRows(at: [IndexPath(item: indexPath.item, section: indexPath.section)], with: .automatic)
                    tableView.deleteRows(at: [IndexPath(row: indexPath.row-1, section: indexPath.section), IndexPath(row: indexPath.row-2, section: indexPath.section), IndexPath(row: indexPath.row-3, section: indexPath.section)], with: .top)}, completion: nil)
            }
            
        default:
            break
        }
    }
    
    // MARK Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return SelectionRowKeys.allSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SelectionRowKeys.allSections[section].title()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectionRowKeys.allSections[section].child(isExpanded: isExpanded).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SelectionRowKeys.allSections[indexPath.section]
        let row = section.child(isExpanded: isExpanded)[indexPath.row]

        let cellIdentifier = row == .userProfile ?"user" :"page"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let title = row.title(withUser: user, isExpanded: isExpanded)
        let imageName = row.image(withUser: user)
        
        if let cell = cell as? FacebookUserTableViewCell{
            cell.userName.text = row.title(withUser: user, isExpanded: isExpanded)
            if let imageName = imageName{
                cell.profilePic.image = UIImage(named: imageName)
            }
        } else {
            cell.textLabel?.text = title
            
            if let imageName = imageName{
                cell.imageView?.image = UIImage(named: imageName)
                cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.textLabel?.textAlignment = .natural
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.imageView?.image = nil
                cell.accessoryType = .none
                if section == .logOut{
                    cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.1273401127, blue: 0, alpha: 1)
                    cell.textLabel?.textAlignment = .center
                } else {
                    cell.textLabel?.textColor = isExpanded ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5764705882, blue: 0.7921568627, alpha: 1)
                    cell.textLabel?.textAlignment = .natural
                }
            }
        }
        return cell
    }
}

