//
//  WeatherCardViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit

class WeatherCardViewCell: UICollectionViewCell {
    
    private lazy var weatherCardView: WeatherCardView = {
        let view = WeatherCardView()
        view.backgroundColor = .brown
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupSubviews() {
        contentView.addSubview(weatherCardView)
    }
    
    private func setupConstraints() {
        weatherCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

