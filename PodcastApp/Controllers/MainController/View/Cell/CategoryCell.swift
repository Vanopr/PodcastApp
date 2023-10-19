//
//  CategoryCell.swift
//  Test6
//
//  Created by Vanopr on 26.09.2023.
//


import Foundation
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "noImage")
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var cardView: UIView = {
        let viewCardView = UIView()
        viewCardView.backgroundColor = .ghostWhite.withAlphaComponent(0.7)
        viewCardView.layer.cornerRadius = 10
        viewCardView.translatesAutoresizingMaskIntoConstraints = false
        return viewCardView
    }()
    
  static let identifier = "CategoryCell"
    private var categoryLabelTob = UILabel.makeLabel(text: "", font: .manropeBold(size: 16), textColor: .black)
    private var categoryLabelBottom = UILabel.makeLabel(text: "", font: .manropeRegular(size: 14), textColor: .gray)
  let stackView = UIStackView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupUICell()
  }

    private func setupUICell() {
    backgroundColor = .white
    layer.masksToBounds = false
    layer.cornerRadius = 10
    categoryLabelTob.numberOfLines = 0
    categoryLabelTob.adjustsFontSizeToFitWidth = true
    categoryLabelBottom.numberOfLines = 1
    categoryLabelBottom.adjustsFontSizeToFitWidth = true
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 0
      
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
      stackView.addArrangedSubview(categoryLabelTob)
      stackView.addArrangedSubview(categoryLabelBottom)
      contentView.addSubview(imageView)
      imageView.addSubview(cardView)
      cardView.addSubview(stackView)
  }

  private func setupConstraints() {
      imageView.snp.makeConstraints { make in
          make.bottom.leading.trailing.top.equalTo(contentView)
      }
      cardView.snp.makeConstraints { make in
          make.bottom.leading.trailing.equalTo(imageView)
          make.height.equalTo(64)
      }
      
      stackView.snp.makeConstraints { make in
          make.centerY.equalTo(cardView)
          make.height.equalTo(cardView)
          make.leading.equalTo(cardView).offset(3)
          make.trailing.equalTo(cardView).inset(3)
      }
  }
    public func setupCategoryCell(topLbl: String, bottomLbl: Int, image: UIImage?) {
        categoryLabelTob.text = topLbl
        categoryLabelBottom.text = String(bottomLbl) + " podcasts"
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "noImage")
        }
    }
}
