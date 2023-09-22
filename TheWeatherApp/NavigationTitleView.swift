//
//  NavigationTitleView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit

class NavigationTitleView: UIView {

    let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "City, Country"
            // Настройки вашего label
            return label
        }()
        
        let dotsProgressBar: DotsProgressBar = {
            let progressBar = DotsProgressBar()
            progressBar.numberOfDots = 2
            return progressBar
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, dotsProgressBar])
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
            
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
}
