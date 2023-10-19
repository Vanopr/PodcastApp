//
//  MainProfileView.swift
//  PodcastApp
//
//  Created by Vanopr on 26.09.2023.
//


import Foundation
import UIKit
import SnapKit

class MainProfileView: UIView {
  private var whiteBackgroundView = UIView.makeView(backgroundColor: .white, cornerRadius: 5)
    
  var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 5
    imageView.backgroundColor = .palePink
    imageView.image = UIImage(systemName: "person.fill")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
    
    var nameLbl: UILabel = {
      let label = UILabel()
        label.font = .manropeExtraBold(size: 16)
        label.text = "Ivan Ivanov"
        label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    var statusLbl: UILabel = {
      let label = UILabel()
        label.font = .manropeRegular(size: 14)
        label.text = "Love, Life, Chill."
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    var stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .equalSpacing
      stackView.axis = .vertical
      stackView.alignment = .leading
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
    }()
    
  var cardView: UIView = {
    let view = UIView()
      view.backgroundColor = .white
      view.layer.cornerRadius = 10
      view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

    override init(frame: CGRect) {
      super.init(frame: frame)
        setupUI()
        setupLayout()
    }

  required init?(coder: NSCoder) {
    fatalError("Please use this class from code.")
  }

  private func setupUI() {
    addSubview(cardView)
    cardView.addSubview(whiteBackgroundView)
      cardView.addSubview(imageView)
      cardView.addSubview(stackView)
      stackView.addArrangedSubview(nameLbl)
      stackView.addArrangedSubview(statusLbl)
  }

  private func setupLayout() {
      cardView.snp.makeConstraints { make in
          make.leading.equalToSuperview()
          make.trailing.equalToSuperview()
          make.top.equalToSuperview()
          make.bottom.equalToSuperview()
      }

      imageView.snp.makeConstraints { make in
          make.trailing.equalTo(cardView)
          make.centerY.equalTo(cardView)
          make.width.equalTo(50)
          make.height.equalTo(50)
      }

      stackView.snp.makeConstraints { make in
          make.leading.equalTo(cardView)
          make.trailing.equalTo(imageView.snp.leading)
          make.centerY.equalTo(cardView)
      }
      
      whiteBackgroundView.snp.makeConstraints { make in
          make.edges.equalTo(imageView)
      }
  }
}
