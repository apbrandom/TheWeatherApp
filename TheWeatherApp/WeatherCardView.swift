//
//  WeatherCardView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit

class WeatherCardView: UIView {

    private lazy var temperatureLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            return label
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()
        
        // MARK: - Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubviews()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            // Здесь следует избегать использования force unwrap
            return nil
        }
        
        private func setupSubviews() {
            addSubview(temperatureLabel)
            addSubview(iconImageView)
        }
        
        private func setupConstraints() {
            temperatureLabel.snp.makeConstraints { make in
                make.center.equalTo(snp.center)
            }
            
            iconImageView.snp.makeConstraints { make in
                make.top.equalTo(snp.top).offset(8)
                make.centerX.equalTo(snp.centerX)
            }
        }

}
