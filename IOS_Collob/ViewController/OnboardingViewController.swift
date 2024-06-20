//
//  OnboardingViewController.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    var slides = [OnboardingSlide]()
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                btnNext.setTitle("Get Started", for: .normal)
            }else{
                btnNext.setTitle("Next", for: .normal)
            }
        }
    }

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var OnboardingCollectionView: UICollectionView!
    
//  MARK: - All view lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        OnboardingCollectionView.delegate = self
        OnboardingCollectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "Music on the way", description: "Today's biggest and hottest tracks from across the world music landscape.", image: UIImage(named: "boy-listening-music")!),
            OnboardingSlide(title: "Rock on your way", description: "Today's biggest and hottest tracks from across the world music landscape.", image: UIImage(named: "man-listening-music")!),
            OnboardingSlide(title: "Music on the way", description: "Today's biggest and hottest tracks from across the world music landscape.", image: UIImage(named: "woman-listening-music")!)
                ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnNext.layer.cornerRadius =  26.0
        btnNext.clipsToBounds = true
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()

      guard let flowLayout = OnboardingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
        return
      }

        if UIApplication.shared.statusBarOrientation.isLandscape {
        //here you can do the logic for the cell size if phone is in landscape
            OnboardingCollectionView.reloadData()
      } else {
        //logic if not landscape
      }

      flowLayout.invalidateLayout()
    }
    
//  MARK: - All IBActions Methods
    
    @IBAction func onNextBtnPressed(_ sender: Any) {
        if currentPage == slides.count - 1{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
            
            
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .partialCurl
            present(controller, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            OnboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

    }
    
    
    
}

// MARK: - All Extensions

extension OnboardingViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onboardingCell = OnboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        let slide = slides[indexPath.item]
        
        onboardingCell.slideImage.image = slide.image
        onboardingCell.lblSlideTitle.text = slide.title
        onboardingCell.lblSlideDescription.text = slide.description
        
        return onboardingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OnboardingCollectionView.frame.width, height: OnboardingCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
}

extension UIView {

    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }


    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
