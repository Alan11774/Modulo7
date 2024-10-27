//
//  DetailView.swift
//  Pets
//
//  Created by Ángel González on 19/10/24.
//

import UIKit

class DetailView: UIView {
    let tv = UITextView()
    
    override func draw(_ rect: CGRect) {
        tv.frame = rect
        tv.backgroundColor = .lightGray
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(tv)
    }

}
