//
//  LoaderView.swift
//  Effects
//
//  Created by Alan Ulises on 19/10/24.
//

import UIKit

import Lottie

class LoaderView:UIView{
    public class LoaderView: UIView{
        var animationView = LottieAnimationView(name:"Lottie Lego")
        override public init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        required init?(coder aDecoder: NSCoder){
            super.init(coder: aDecoder)
            
            commonInit()
        }
        func commonInit(){
        
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.center
            animationView.animationSpeed = 0.2
            animationView.contentMode = .scaleToFill
            self.addSubview(animationView)
            animationView.play()
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            animationView.widthAnchor.constraint(equalToConstant: 280).isActive = true
            animationView.heightAnchor.constraint(equalToConstant: 108).isActive = true
            
            

        }
        func repintar(_ segmento: String){
            animationView.removeFromSuperview()
            animationView = LottieAnimationView(name: segmento)
            commonInit()
        }

    }
         
            
            
}

