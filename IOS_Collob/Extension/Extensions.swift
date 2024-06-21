//
//  Extensions.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import Foundation
import UIKit

// MARK: - Home VC User Defined Functions
extension HomeViewController {
    func setGradientBackground(view: UIView) {
        let colorTop = UIColor(named: "TopColour")!.cgColor
        let colorBottom = UIColor(named: "BottomColour")!.cgColor
                    
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.3]
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }

    func setupUI(){
        //Customize the Search Text Field
        tfSearch.borderStyle = .none
        tfSearch.attributedPlaceholder =
        NSAttributedString(string: "Find your Favourite Music!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])

        // Customize the Search View
        viewSearch.applyCornerRadius(radius: 20)
        
        viewSearch.backgroundColor = .systemGray6
        
        viewSearch.dropShadow()
    }
}

// MARK: - Move To Different Screens
extension HomeViewController: MovetoScreen {
    
    func MoveToDetailScreen(ImageName: String) {
        let DetailsScreenObj = UIStoryboard(name: "DetailScreen", bundle: nibBundle).instantiateViewController(withIdentifier: "DetailsScreenVC") as! DetailsScreenVC
        
        DetailsScreenObj.imageCover = ImageName
       DetailsScreenObj.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(DetailsScreenObj, animated: true)
    }
    
    func MovetoSingerProfileScreen(index: Int){
        let profile = UIStoryboard(name: "UserProfile", bundle: nibBundle).instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        //profile.index = index
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    @objc func MoveToPreviousScreen(){
        print("Move To Previous Screen")
        self.tabBarController?.navigationController?.popViewController(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - HomeVC Table View Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        /*
         1. New Release
         2. Popular
         3. Top Singer
         */
        3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Develop Custom Header Here
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        // Take a Label for Section Title
        let label = UILabel()
        label.frame = CGRect.init(x: 30, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = sectionTitles[section]
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black

        // Add the Label in headerView
        headerView.addSubview(label)
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        // Provide the height to each section
        return 40
    }
        

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // No. of row each section contains
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Save the section index in index variable.
        let index = indexPath.section
        
        // Every index will have their own Contents, but the Prototype Cell will be the same for each section.
        if index == 0{
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.delegate = self
            cell.albums = newReleasesAlbum
            cell.albumNames = newReleaseAlbumName
            cell.albumSingers = newReleaseAlbumSingers
            return cell
        }else if index == 1{
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.delegate = self
            cell.albums = popularAlbum
            cell.albumNames = popularAlbumName
            cell.albumSingers = popularAlbumSingers
            return cell
        }else{
            
            // Top Singers section have different fields hence to know that it is Top Singer section isSingers variable will be set to true.
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.isSingers = true
            cell.delegateSinger = self
            cell.albums = topSingers
            cell.albumSingers = topSingerNames
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Height for the Cells
        let index = indexPath.section
        
        if index == 2{
            // Top Singer Section
            return 145
        }else{
            
            // New Release and Popular Songs Section
            return 160
        }
        
    }
}

// MARK: - UIView Extension
extension UIView {
    func applyCornerRadius(radius: CGFloat) {
        
        // Set CornerRadius provided by the user and clips to bounds true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeCircle(){
        
        // Half the width of frame of given view and call applyCornerRadius()
        self.applyCornerRadius(radius: self.frame.width / 2)
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = 1

        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
