//
//  HomeViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovetoScreen {

    @IBOutlet weak var HomeTableView: UITableView!
    
    var gradientLayer: CAGradientLayer!
    
    // MARK: - All Static Data
    var sectionTitles = ["New Release", "Popular", "Top Singer"]
    
    var newReleasesAlbum = ["Music-Album-1", "Music-Album-2","Music-Album-3","Music-Album-4","Music-Album-5"]
    var newReleaseAlbumName = ["Saheb Bibi", "One Night", "Party Mashup", "Today Arrives", "Starboy"]
    var newReleaseAlbumSingers = ["Dip Kamal", "Taylor Swift", "Random", "Joe Dragon", "Raftaar"]
    
    var popularAlbum = ["Music-Album-6","Music-Album-7","Music-Album-8","Music-Album-9","Music-Album-10"]
    var popularAlbumName = ["This Moment", "One Night", "Party Mashup", "Today Arrives", "Starboy"]
    var popularAlbumSingers = ["Taylor Swift", "Taylor Swift", "Random", "Joe Dragon", "Raftaar"]
    
    var topSingers = ["singer-1","singer-2","singer-3","singer-4","singer-5"]
    var topSingerNames = ["Shakira", "Arijit Singh", "Shreya Ghosal", "Alan Walker", "Eminem"]
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(view: view)
        
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = view.layer.bounds
    }
    
    // MARK: - Table View Delegates
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        /*
         Custom Header View For Section,
         As Section Title will be changed only
         */
        
        if section > 0{
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = sectionTitles[section - 1]
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = .black
        
            headerView.addSubview(label)
            
            return headerView
        }else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        /* No Section Height For First Cell */
        if section > 0 {
            return 40
        }else {
            return 0
        }
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Each section will have one row
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         
         Here, AlbumTableViewCell will be Common For New Release and Popular Album
         sections.
         
         */
        
        let index = indexPath.section
        
        if index == 0 {
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            return cell
        }else if index == 1{
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.delegate = self
            cell.albums = newReleasesAlbum
            cell.albumNames = newReleaseAlbumName
            cell.albumSingers = newReleaseAlbumSingers
            return cell
        }else if index == 2{
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.delegate = self
            cell.albums = popularAlbum
            cell.albumNames = popularAlbumName
            cell.albumSingers = popularAlbumSingers
            return cell
        }else{
            let cell = HomeTableView.dequeueReusableCell(withIdentifier: "TopSingerTableViewCell", for: indexPath) as! TopSingerTableViewCell
            cell.singers = topSingers
            cell.singerNames = topSingerNames
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Height for the Cells
        let index = indexPath.section
        if index == 0{
            return 62
        }else if index == 3{
            return 143
        }else{
            return 160
        }
        
    }
        
        
    func MoveToDetailScreen(ImageName: String) {
        let DetailsScreenObj = UIStoryboard(name: "DetailScreen", bundle: nibBundle).instantiateViewController(withIdentifier: "DetailsScreenVC") as! DetailsScreenVC
        
        DetailsScreenObj.imageCover = ImageName
       DetailsScreenObj.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(DetailsScreenObj, animated: true)
    }
}

