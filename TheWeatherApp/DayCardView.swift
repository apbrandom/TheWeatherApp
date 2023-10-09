//
//  DayCard.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit
import SnapKit

class DayCardView: UIView {
    
    //MARK: - Subviews
    private lazy var ellipseImage = {
        let image = UIImageView(image: .ellipse)
        image.tintColor = .yell
        return image
    }()
    
    private lazy var sunriseImage = {
        let image = UIImageView(image: .sunrise)
        image.tintColor = .yell
        return image
    }()
    
    lazy var sunriseLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var sunsetImage = {
        let image = UIImageView(image: .sunset)
        image.tintColor = .yell
        return image
    }()
    
    lazy var sunsetLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var dayCardVstack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    //MARK: - VStack
    lazy var tempMinMaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    lazy var condintionLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var dayCardHstack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    lazy var currentDateLabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    //MARK: - HStack
    private lazy var chanceOfRainImage = {
        let image = UIImageView(image: .chanceRain)
        return image
    }()
    
    lazy var chanceOfRainLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var windSpeedImage = {
        let image = UIImageView(image: .windSpeed)
        image.tintColor = .yell
        return image
    }()
    
    lazy var windSpeedLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var humidityImage = {
        let image = UIImageView(image: .humidity)
        image.tintColor = .white
        return image
    }()
    
    lazy var humidityLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .tintColor
    }
    
    private func addSubviews() {
        addSubview(ellipseImage)
        addSubview(sunriseImage)
        addSubview(sunriseLabel)
        addSubview(sunsetImage)
        addSubview(sunsetLabel)
        addSubview(dayCardVstack)
        
        //VStack
        dayCardVstack.addArrangedSubview(tempMinMaxLabel)
        dayCardVstack.addArrangedSubview(tempLabel)
        dayCardVstack.addArrangedSubview(condintionLabel)
        dayCardVstack.addArrangedSubview(dayCardHstack)
        dayCardVstack.addArrangedSubview(currentDateLabel)
        
        //HStack
        dayCardHstack.addArrangedSubview(chanceOfRainImage)
        dayCardHstack.addArrangedSubview(chanceOfRainLabel)
        dayCardHstack.addArrangedSubview(windSpeedImage)
        dayCardHstack.addArrangedSubview(windSpeedLabel)
        dayCardHstack.addArrangedSubview(humidityImage)
        dayCardHstack.addArrangedSubview(humidityLabel)
    }
    
    private func setupConstrains() {
        ellipseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(36)
            make.top.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(75)
        }
        
        sunriseImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(29)
            make.bottom.equalTo(ellipseImage.snp.bottom).offset(20)
            make.width.height.equalTo(18)
        }
        
        sunriseLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(sunriseImage.snp.bottom).offset(5)
        }
        
        sunsetImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(29)
            make.bottom.equalTo(ellipseImage.snp.bottom).offset(20)
            make.width.height.equalTo(18)
        }
        
        sunsetLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(sunsetImage.snp.bottom).offset(5)
        }
        
        dayCardVstack.snp.makeConstraints { make in
            make.top.equalTo(ellipseImage.snp.top).inset(10)
            make.bottom.equalToSuperview().inset(22)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
        
        dayCardHstack.snp.makeConstraints { make in
            make.width.equalTo(dayCardVstack).inset(40)
        }
        
        chanceOfRainImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        windSpeedImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        humidityImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
}
