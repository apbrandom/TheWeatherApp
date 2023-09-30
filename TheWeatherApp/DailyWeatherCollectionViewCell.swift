//
//  DailyWeatherCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 29.09.2023.
//

import UIKit
import SnapKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    lazy var dataLabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var chanceOfRainImage = {
        let image = UIImageView(image: .chanceRain)
        return image
    }()
    
    lazy var chanceOfRainLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    lazy var conditionLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()
    
    lazy var temperatureRangeLabel = {
        let label = UILabel()
        label.text = "4-11"
        label.font = UIFont.systemFont(ofSize: 18)
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
    
    
    private func setupView() {
        backgroundColor = .secBackground
        layer.cornerRadius = 10
    }
    
    private func setupSubviews() {
        addSubview(dataLabel)
        addSubview(chanceOfRainLabel)
        addSubview(chanceOfRainImage)
        addSubview(conditionLabel)
        addSubview(temperatureRangeLabel)
    }
    
    private func setupConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(conditionLabel.snp.leading).offset(-10)
        }
        
        chanceOfRainLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(7)
            make.trailing.equalTo(conditionLabel.snp.leading).offset(-10)
        }
        
        chanceOfRainImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(7)
            make.top.equalTo(dataLabel.snp.bottom).offset(5)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(70)
        }
        
        temperatureRangeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(conditionLabel.snp.trailing).offset(5)
        }
    }
    
}
