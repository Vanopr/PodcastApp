//
//  SeeAllView.swift
//  PodcastApp
//
//  Created by Vanopr on 26.09.2023.
//

import Foundation
import UIKit

class MainSeeAllView: UIView {
  private var whiteBackgroundView = UIView.makeView(backgroundColor: .white, cornerRadius: 5)

    private let categoryLbl: UILabel = {
      let label = UILabel()
        label.font = .manropeExtraBold(size: 16)
        label.text = "Category"
        label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.imageView?.tintColor = .gray
        button.titleLabel?.font = .manropeRegular(size: 16)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
  private  var stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .equalSpacing
      stackView.axis = .horizontal
      stackView.alignment = .leading
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
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
    addSubview(whiteBackgroundView)
      whiteBackgroundView.addSubview(stackView)
      stackView.addArrangedSubview(categoryLbl)
      stackView.addArrangedSubview(seeAllButton)
  }

  private func setupLayout() {
      whiteBackgroundView.snp.makeConstraints { make in
          make.leading.equalToSuperview()
          make.trailing.equalToSuperview()
          make.top.equalToSuperview()
          make.bottom.equalToSuperview()
      }

      stackView.snp.makeConstraints { make in
          make.leading.trailing.equalTo(whiteBackgroundView)
          make.centerY.equalTo(whiteBackgroundView)
      }
  }
}
