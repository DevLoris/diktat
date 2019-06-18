//
//  TutorialViewController.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 03/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    //Bullets
    @IBOutlet weak var bulletView1: UIImageView!
    @IBOutlet weak var bulletView2: UIImageView!
    @IBOutlet weak var bulletView3: UIImageView!
    
    @IBOutlet weak var sliderView: UIView!
    
    //View 1
    @IBOutlet weak var slideView1: UIView!
    @IBOutlet weak var imageSlideView1: UIImageView!
    
    //View 2
    @IBOutlet weak var slideView2: UIView!
    @IBOutlet weak var imageSlideView2: UIImageView!
    
    //View 3
    @IBOutlet weak var slideView3: UIView!
    @IBOutlet weak var imageSlideView3: UIImageView!
    
    // Keeping image timer (used for image 1, to animate the motion)
    var imageChangeTimer: Timer? = nil
    var imageIndexView = 0
    
    // Progression
    var activeBullet = 1
    var maxBullet = 3
    
    var slides: [UIView] = []
    
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        slides = [slideView1, slideView2, slideView3]
        
        // Set bullet items as touchable
        setBulletViewsTouchable()
        
        // Set swipe events for left and right
        setSwipeEvent(direction: .left)
        setSwipeEvent(direction: .right)
        
        // Activating the first slide
        setActiveSlide(slideIndex: 0, isInit: true)
    }
    
    // Adding touch event on every "bullet" item
    func setBulletViewsTouchable() -> Void {
        let bulletsViews:[UIImageView] = [self.bulletView1, self.bulletView2, self.bulletView3]
        
        bulletsViews.forEach { (im) in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBulletTouch(tapGestureRecognizer:)))
            im.isUserInteractionEnabled = true
            im.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    // Add a swipe event to the view, for a given direction
    func setSwipeEvent(direction: UISwipeGestureRecognizer.Direction) {
        let swipeEvent = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeEvent.direction = direction
        self.view.addGestureRecognizer(swipeEvent)
    }
    
    // Set a slide as active and trigger its animation
    func setActiveSlide(slideIndex: Int, isInit: Bool = false) -> Void {
        if slideIndex == activeBullet && !isInit { return }
   
        animateSlide(slideIndex: slideIndex, isInit: isInit)
        setActiveBullet(activeIndex: slideIndex)
        
        if let timer = imageChangeTimer {
            timer.invalidate()
            imageChangeTimer = nil
        }
        
        imageIndexView = 0
        
        var selector: Selector;
        
        switch slideIndex {
            case 0:
                selector = #selector(self.autoChangeImage1)
            case 1:
                selector = #selector(self.autoChangeImage2)
            default:
                return
        }
        
        imageChangeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    // Animate a slide
    func animateSlide(slideIndex: Int, isInit: Bool) -> Void {
        let sliderWidth = sliderView.frame.width
        
        if isInit {
            // In case of init, we need to translate to every slide except the first one
            for (index, element) in slides.enumerated() {
                if index != 0 {
                    element.transform = CGAffineTransform(translationX: sliderWidth, y: 0)
                }
            }
            
            return
        }
        
        // Slide animations are only activated if it's not initialization
        let actualSlide = slides[activeBullet]
        let newSlide = slides[slideIndex]
        
        // Actual bullet should go to the left and the new one arrives from the right
        let dir: CGFloat = slideIndex >= activeBullet ? 1 : -1;
        
        newSlide.transform = CGAffineTransform(translationX: sliderWidth * dir, y: 0)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            newSlide.transform = CGAffineTransform(translationX: 0, y: 0)
            actualSlide.transform = CGAffineTransform(translationX: -dir * sliderWidth, y: 0)
        })
    }
    
    // Set bullets images depending on the active bullet
    func setActiveBullet(activeIndex: Int) -> Void {
        if activeIndex >= maxBullet { return }

        // Set circle type depending on the active bullet
        bulletView1.image = UIImage(named: activeIndex == 0 ? "circle_full" : "circle_empty")
        bulletView2.image = UIImage(named: activeIndex == 1 ? "circle_full" : "circle_empty")
        bulletView3.image = UIImage(named: activeIndex == 2 ? "circle_full" : "circle_empty")
        
        activeBullet = activeIndex
    }
    
    // Change image1
    @objc func autoChangeImage1() -> Void {
        // Change image in this function
        imageSlideView1.image = UIImage(named: "tutorial-1-" + String(imageIndexView))
        
        imageIndexView += 1
        
        if imageIndexView >= 4 {
            imageIndexView = 0
        }
    }
    
    // Change image2
    @objc func autoChangeImage2() -> Void {
        //change image in this function
        imageSlideView2.image = UIImage(named: "tutorial-2-" + String(imageIndexView))
        
        imageIndexView += 1
        
        if imageIndexView >= 2 {
            imageIndexView = 0
        }
    }
    
    // Clic detection on bullet
    @objc func handleBulletTouch(tapGestureRecognizer: UITapGestureRecognizer) -> Void {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage {
            case bulletView1:
                setActiveSlide(slideIndex: 0)
            case bulletView2:
                setActiveSlide(slideIndex: 1)
            case bulletView3:
                setActiveSlide(slideIndex: 2)
            default:
                setActiveSlide(slideIndex: 2)
        }
    }
    
    // Swipe detection to go through tutorial
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if activeBullet > 0 {
                setActiveSlide(slideIndex: activeBullet - 1)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if activeBullet < maxBullet - 1 {
                setActiveSlide(slideIndex: activeBullet + 1)
            }
        }
    }
    
    
    @IBAction func dismissTutorialButton(_ sender: Any) -> Void {
        performSegue(withIdentifier: "ar-view", sender: self)
    }
}
