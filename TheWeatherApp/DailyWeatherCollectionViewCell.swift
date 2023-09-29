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
        label.text = "21/04"
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
        label.text = "57%"
        return label
    }()
    
    lazy var conditionLabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "Местами дождь"
        return label
    }()
    
    lazy var temperatureLabel = {
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
        addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        
        dataLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(7)
        }
        
        chanceOfRainImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(7)
            make.top.equalTo(dataLabel.snp.bottom).offset(5)
        }
        
        chanceOfRainLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(7)
            make.leading.equalTo(chanceOfRainImage.snp.trailing).offset(2)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(70)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
}
