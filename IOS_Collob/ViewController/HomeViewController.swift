//
//  HomeViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var HomeTableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var menuBtn: UIButton!
    
    // MARK: - Global Variables
    var gradientLayer: CAGradientLayer!
    var menu: SideMenuNavigationController?
    
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
        HomeTableView.showsVerticalScrollIndicator = false
        
        setupUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(view: view)

      NotificationCenter.default.addObserver(self, selector: #selector(MoveToPreviousScreen), name: NSNotification.Name("LogoutUser"), object: nil) 
      self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        gradientLayer.frame = view.layer.frame
    }
    
//    override func viewDidLayoutSubviews() {
//        gradientLayer.frame = view.layer.frame
//    }
    
    // MARK: - IB Actions
    @IBAction func actionMenuBtn(_ sender: Any) {
        //MenuListController().delegatePop = self
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        
        menu?.setNavigationBarHidden(true, animated: false)
        menu?.presentationStyle = .viewSlideOutMenuPartialOut
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        present(menu!, animated: true, completion: nil)
    }
    

    
}

