//
//  WeatherCardViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit

class WeatherCardViewCell: UICollectionViewCell {
    
    //MARK: - Subviews
    lazy var temperatureLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var conditionIconImageView = {
        let imageView = UIImageView()
        imageView.image = .sun
        return imageView
    }()
    
    lazy var hourTimeIntervalLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Setup Methods
    private func setupSubviews() {
        addSubview(temperatureLabel)
        addSubview(conditionIconImageView)
        addSubview(hourTimeIntervalLabel)
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tintColor.cgColor
    }
    
    private func setupConstraints() {
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalToSuperview().inset(10)
        }
        
        conditionIconImageView.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.height.lessThanOrEqualTo(20)
        }
        
        hourTimeIntervalLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalToSuperview().inset(15)
        }
    }
}

