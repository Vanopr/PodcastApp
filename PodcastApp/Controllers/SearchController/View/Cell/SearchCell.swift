//
//  SearchCell.swift
//  PodcastApp
//
//  Created by Vanopr on 03.10.2023.
//

import Foundation
import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {

  static let identifier = "SearchCell"
  private var label = UILabel.makeLabel(text: "", font: .manropeRegular(size: 14), textColor: .white)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupUICell()
  }

  func setupUICell() {
    layer.masksToBounds = false
    layer.cornerRadius = 15
    label.numberOfLines = 1
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = false
    layer.backgroundColor = UIColor.blueSearchCell.cgColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with title: String) {
    label.text = title
  }

  private func setupViews() {
    contentView.addSubview(label)
  }

  private func setupConstraints() {
      label.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
  }
}
