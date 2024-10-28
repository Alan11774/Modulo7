//
//  DetailView.swift
//  Pets
//
//  Created by Ángel González on 19/10/24.
//

import UIKit

class DetailView: UIView {

    var tv: UITextView!
    var iv: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  private func setupView() {
    // Customize the background with a gradient (optional)
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = [UIColor.systemGray6.cgColor, UIColor.systemGray5.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    self.layer.insertSublayer(gradientLayer, at: 0)

    // Text view
    tv = UITextView(frame: .zero)
    tv.backgroundColor = .white
    tv.layer.cornerRadius = 15
    tv.layer.shadowColor = UIColor.black.cgColor
    tv.layer.shadowOffset = CGSize(width: 0, height: 4)
    tv.layer.shadowOpacity = 0.2
    tv.layer.shadowRadius = 10
    tv.isEditable = false
    tv.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    tv.textColor = UIColor.darkGray
    tv.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    self.addSubview(tv)

    // Image view
    iv = UIImageView(frame: .zero)
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    self.addSubview(iv)

    // Add constraints (adjust as needed)
    NSLayoutConstraint.activate([
        tv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
      tv.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      tv.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      tv.heightAnchor.constraint(equalToConstant: 100), // adjust height as needed

      iv.topAnchor.constraint(equalTo: tv.bottomAnchor, constant: 20),
      iv.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      iv.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      iv.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
    ])
  }

  // Function to set the image from a file path
  func setImage(from filePath: URL) {
    do {
      let data = try Data(contentsOf: filePath)
      let image = UIImage(data: data)
      iv.image = image
    } catch {
        iv.image = UIImage(named: "profile_empty.jpg")
        print("Error loading image: \(error.localizedDescription)")
    }
  }
}
