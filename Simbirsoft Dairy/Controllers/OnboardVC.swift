//
//  OnboardVC.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import UIKit
import SwiftyOnboard

class OnboardVC: UIViewController {
    
    let onboardTitleArray: [String] = ["Keep your diary", "Add New Tasks", "Share With Friends"]
    let onboardSubTitleArray: [String] = [" Scroll through the months", "Don't forget anything", "Created by Nikolai Saganenko as a SimbirSoft test task"]

    var swiftyOnboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .white
        }
        
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }

    @objc func handleSkip() {
        goToCalendar()
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        if index == 2 {
            goToCalendar()
        } else {
            print("Next")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
    }
    
    func goToCalendar() {
        let nc = UINavigationController(rootViewController: CalendarVC())
        nc.navigationBar.backgroundColor = .systemBackground
        nc.modalPresentationStyle = .overFullScreen
        present(nc, animated: true, completion: nil)
    }
}

//MARK: - SwiftyOnboard protocols

extension OnboardVC: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        3
    }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        page.title.text = onboardTitleArray[index]
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 34)

        page.subTitle.text = onboardSubTitleArray[index]
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 22)
        
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .white
        }

        page.imageView.image = UIImage(named: "\(index).jpeg")
        
        return page
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        return overlay
    }
   
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
        }
    }
}
