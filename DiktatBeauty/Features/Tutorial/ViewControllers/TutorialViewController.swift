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
    var currentIndex = 1
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
        setActiveSlide(index: 0)
        initSlidesPosition()
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
    
    // Set the active slide
    func setActiveSlide(index: Int) -> Void {
        let oldIndex = currentIndex
        currentIndex = index
        
        animateChangeSlide(oldIndex: oldIndex)
        animateSlide()
        updateBulletsImage()
    }
    
    // Animate slide change
    func animateChangeSlide(oldIndex: Int) -> Void {
        let sliderWidth = sliderView.frame.width
        let oldSlide = slides[oldIndex]
        let newSlide = slides[currentIndex]
        
        // Old slide should go to the left and the new one arrive from the right
        let dir: CGFloat = currentIndex >= oldIndex ? 1 : -1;
        
        newSlide.transform = CGAffineTransform(translationX: sliderWidth * dir, y: 0)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            newSlide.transform = CGAffineTransform(translationX: 0, y: 0)
            oldSlide.transform = CGAffineTransform(translationX: -dir * sliderWidth, y: 0)
        })
    }
    
    // Animate a slide
    func animateSlide() -> Void {
        if let timer = imageChangeTimer {
            timer.invalidate()
            imageChangeTimer = nil
        }
        
        imageIndexView = 0
        
        var selector: Selector;
        
        switch currentIndex {
            case 0:
                selector = #selector(self.autoChangeImage1)
            case 1:
                selector = #selector(self.autoChangeImage2)
            default:
                return
        }
        
        imageChangeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    // Translate to every slide except the first one
    func initSlidesPosition() -> Void {
        let sliderWidth = sliderView.frame.width
        
        for (index, element) in slides.enumerated() {
            if index != 0 {
                element.transform = CGAffineTransform(translationX: sliderWidth, y: 0)
            }
        }
    }
    
    // Set bullets images depending on the active bullet
    func updateBulletsImage() -> Void {
        if currentIndex >= maxBullet { return }

        bulletView1.image = UIImage(named: currentIndex == 0 ? "circle_full" : "circle_empty")
        bulletView2.image = UIImage(named: currentIndex == 1 ? "circle_full" : "circle_empty")
        bulletView3.image = UIImage(named: currentIndex == 2 ? "circle_full" : "circle_empty")
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
                setActiveSlide(index: 0)
            case bulletView2:
                setActiveSlide(index: 1)
            case bulletView3:
                setActiveSlide(index: 2)
            default:
                setActiveSlide(index: 2)
        }
    }
    
    // Swipe detection to go through tutorial
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if currentIndex > 0 {
                setActiveSlide(index: currentIndex - 1)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if currentIndex < maxBullet - 1 {
                setActiveSlide(index: currentIndex + 1)
            }
        }
    }
    
    
    @IBAction func dismissTutorialButton(_ sender: Any) -> Void {
        performSegue(withIdentifier: "ar-view", sender: self)
    }
}
