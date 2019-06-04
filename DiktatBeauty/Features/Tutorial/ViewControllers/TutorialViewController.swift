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
    
    //Stocke le timer pour l'image (utilisé pour l'image 1, pour animer le mouvement)
    var imageChangeTimer:Timer? = nil
    var imageIndexView = 0
    
    //Progression
    var actualBullet = 1
    var maxBullet = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bulletsViews:[UIImageView] = [self.bulletView1, self.bulletView2, self.bulletView3]
 
        //On ajoute un touch event sur toutes les images "bullets"
        bulletsViews.forEach { (im) in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            im.isUserInteractionEnabled = true
            im.addGestureRecognizer(tapGestureRecognizer)
        }
        
        //On ajoute le swipe event
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        //On active juste la première slide
        setSlide(slide: 0, is_init: true)
        
    }
    
    
    
    func setSlide(slide:Int, is_init:Bool = false)  {
        if(slide == actualBullet && !is_init) {
            return
        }
        
        //Liste des slides et large du slider
        let slides:[UIView] = [slideView1, slideView2, slideView3]
        let sliderWidth = sliderView.frame.width
        
        //Les animations de slide etc ne se font que si on n'est pas à l'initialisation
        if(!is_init) {
            let actualSlide =  slides[actualBullet]
            let newSlide =  slides[slide]
            
            //l'actual doit swipe à gauche ; le nouveau arrive pas la droite
            var dir:CGFloat = 1;
            if (slide < actualBullet) {
                dir = -1;
            }
            
            newSlide.transform = CGAffineTransform(translationX: sliderWidth * dir, y: 0)
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                newSlide.transform = CGAffineTransform(translationX: 0, y: 0)
                actualSlide.transform = CGAffineTransform(translationX: -dir * sliderWidth, y: 0)
            })
        }
        else {
            //On est dans le cas de l'initialisation, il faut juste mettre un translate à tous sauf le premier
            for (index, element) in slides.enumerated() {
                if(index != 0) {
                    element.transform = CGAffineTransform(translationX: sliderWidth, y: 0)
                }
            }
        }
   
        
        setBullet(bullet: slide)
        
        if let timer = imageChangeTimer {
            timer.invalidate()
            imageChangeTimer = nil
        }
        
        imageIndexView = 0
        switch slide {
        case 0:
            imageChangeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.autoChangeImage1), userInfo: nil, repeats: true)
        case 1:
            imageChangeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.autoChangeImage2), userInfo: nil,   repeats: true)
        default: break
        }
    }
    
    func setBullet(bullet:Int) {
        if(bullet < maxBullet) {
            //En fonction de la bullet cliquée, on active les cercles etc
            bulletView1.image = UIImage(named: bullet == 0 ? "circle_full" : "circle_empty")
            bulletView2.image = UIImage(named: bullet == 1 ? "circle_full" : "circle_empty")
            bulletView3.image = UIImage(named: bullet == 2 ? "circle_full" : "circle_empty")
            
            actualBullet = bullet
        }
    }
    
    
    @objc func autoChangeImage1() {
        //change image in this function
        imageSlideView1.image = UIImage(named: "tutorial-1-" + String(imageIndexView))
        
        imageIndexView += 1
        
        if(imageIndexView >= 4) {
            imageIndexView = 0
        }
    }
    
    @objc func autoChangeImage2() {
        //change image in this function
        imageSlideView2.image = UIImage(named: "tutorial-2-" + String(imageIndexView))
        
        imageIndexView+=1
        
        if(imageIndexView >= 2) {
            imageIndexView = 0
        }
    }
    
    //Détection des clicks sur les bullets
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage {
        case bulletView1:
            setSlide(slide: 0)
        case bulletView2:
            setSlide(slide: 1)
        case bulletView3:
            setSlide(slide: 2)
        default:
            setSlide(slide: 2)
        }
    }
    
    //Détection du swipe pour avancer dans le tutorial
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if(actualBullet > 0) {
                setSlide(slide: actualBullet - 1)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if(actualBullet < maxBullet - 1) {
                setSlide(slide: actualBullet + 1)
            }
        }
    }
}
