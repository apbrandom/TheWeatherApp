//
//  DayCard.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit
import SnapKit

class DayCardView: UIView {
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "--"
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "--"
        return label
    }()
    
    private lazy var gradusImage: UIImageView = {
        let image = UIImageView(image: .gradus)
        image.tintColor = .white
        return image
    }()
    
    private lazy var ellipseImage: UIImageView = {
        let image = UIImageView(image: .ellipse)
        image.tintColor = .yell
        return image
    }()
    
    private lazy var sunriseImage: UIImageView = {
        let image = UIImageView(image: .sunrise)
        image.tintColor = .yell
        return image
    }()
    
    private lazy var sunsetImage: UIImageView = {
        let image = UIImageView(image: .sunset)
        image.tintColor = .yell
        return image
    }()
    
    lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "--"
        return label
    }()
    
    lazy var Label: UILabel = {
        let label = UILabel()
        label.textColor = .yell
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "--"
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
        addSubview(tempLabel)
        addSubview(gradusImage)
        addSubview(ellipseImage)
        addSubview(sunriseImage)
        addSubview(sunsetImage)
        addSubview(currentDateLabel)
        addSubview(sunriseLabel)
    }
    
    private func setupConstrains() {
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        gradusImage.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.top)
            make.height.width.equalTo(5)
            make.left.equalTo(tempLabel.snp.right).offset(2)
            }
        
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
        
        currentDateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        

    }
    
}
