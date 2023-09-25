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
    private lazy var ellipseImage: UIImageView = {
        let image = UIImageView(image: .ellipse)
        image.tintColor = .yell
        return image
    }()
    
    private lazy var gradusImage: UIImageView = {
        let image = UIImageView(image: .gradus)
        image.tintColor = .white
        return image
    }()
    
    private lazy var sunriseImage: UIImageView = {
        let image = UIImageView(image: .sunrise)
        image.tintColor = .yell
        return image
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "-"
        return label
    }()
    
    private lazy var sunsetImage: UIImageView = {
        let image = UIImageView(image: .sunset)
        image.tintColor = .yell
        return image
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.text = "--"
        return label
    }()
    
    private lazy var dayCardVstack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .sys
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - VStack
    lazy var tempMinMaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "5/10"
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "--"
        return label
    }()
    
    lazy var condintionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.text = "Возможен небольшой дождь"
        return label
    }()
    
    private lazy var dayCardHstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "--"
        return label
    }()
    
    //MARK: - HStack
    private lazy var sunIndexImage: UIImageView = {
        let image = UIImageView(image: .sunIndex)
        image.tintColor = .yell
        return image
    }()
    
    lazy var sunIndexLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .systemFont(ofSize: 16)
        label.text = "--"
        return label
    }()
    
    private lazy var windSpeedImage: UIImageView = {
        let image = UIImageView(image: .windSpeed)
        image.tintColor = .yell
        return image
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .systemFont(ofSize: 16)
        label.text = "-"
        return label
    }()
    
    private lazy var humidityImage: UIImageView = {
        let image = UIImageView(image: .humidity)
        image.tintColor = .yell
        return image
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .systemFont(ofSize: 16)
        label.text = "-"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .tintColor
    }
    
    private func addSubviews() {
        addSubview(ellipseImage)
        addSubview(gradusImage)
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
        dayCardHstack.addArrangedSubview(sunIndexImage)
        dayCardHstack.addArrangedSubview(sunIndexLabel)
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
            <#code#>
        }
        
//        tempLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(-30)
//        }
        
//        gradusImage.snp.makeConstraints { make in
//            make.top.equalTo(tempLabel.snp.top)
//            make.height.width.equalTo(5)
//            make.left.equalTo(tempLabel.snp.right).offset(2)
//            }
        


        

        

        
 
//        
//        currentDateLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().inset(20)
//        }
        

    }
    
}
