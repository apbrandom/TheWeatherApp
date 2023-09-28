//
//  WeatherCardViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit

class WeatherCardViewCell: UICollectionViewCell {
    lazy var temperatureLabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var conditionIconImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .sun
        return imageView
    }()
    
    lazy var hourTimeIntervalLabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "10:10"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupSubviews() {
        addSubview(temperatureLabel)
        addSubview(conditionIconImageView)
        addSubview(hourTimeIntervalLabel)
    }
    
    private func setupView() {
        backgroundColor = .brown
        layer.cornerRadius = 25
    }
    
    private func setupConstraints() {
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalToSuperview().inset(5)
        }
        
        conditionIconImageView.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
        }
        
        hourTimeIntervalLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalToSuperview().inset(10)
        }
        
    }
}

