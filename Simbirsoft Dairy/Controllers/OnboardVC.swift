//
//  OnboardVC.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import UIKit
import SwiftyOnboard

class OnboardVC: UIViewController {
    
    let onboardTitleArray: [String] = ["Keep your diary", "Add tasks", "Share with friends"]
    let onboardSubTitleArray: [String] = ["everything is at your fingertips", "Easily add new tasks", "One tap to share your task with people"]
    let author: String = "created by Nick Sagan, as a SimbirSoft TestTask"
    
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
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        if index == 2 {
            print("Go to Calendar")
        } else {
            print("Next")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
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

        //page.imageView.image = UIImage(named: "\(index).png")
        
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
            overlay.skipButton.isHidden = true
        }
    }
}
