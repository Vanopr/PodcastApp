//
//  CategoryNamesCell.swift
//  Test6
//
//  Created by Vanopr on 26.09.2023.
//

import Foundation
import UIKit
import SnapKit

class CategoryNameCell: UICollectionViewCell {

  static let identifier = "CategoryNameCell"
  private var categoryLabel = UILabel.makeLabel(text: "", font: .manropeRegular(size: 14), textColor: .gray)

  override var isSelected: Bool {
    didSet {
      if isSelected {
        backgroundColor = UIColor.shadowGray
        categoryLabel.textColor = UIColor.black
        categoryLabel.font = .manropeExtraBold(size: 14)
      } else {
        backgroundColor = UIColor.white
        categoryLabel.textColor = UIColor.gray
        categoryLabel.font = .manropeRegular(size: 14)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupUICell()
  }

  func setupUICell() {
    backgroundColor = .white
    layer.masksToBounds = false
    layer.cornerRadius = 15
    categoryLabel.numberOfLines = 1
    categoryLabel.textAlignment = .center
    categoryLabel.adjustsFontSizeToFitWidth = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with title: String) {
    categoryLabel.text = title
  }

  private func setupViews() {
    contentView.addSubview(categoryLabel)
  }

  private func setupConstraints() {
      categoryLabel.snp.makeConstraints { make in
          make.top.equalTo(contentView)
          make.bottom.equalTo(contentView)
          make.leading.equalTo(contentView)
          make.trailing.equalTo(contentView)
      }
  }
    public func setupCategoryNameCell(with name: String) {
        categoryLabel.text = name 
    }
}
