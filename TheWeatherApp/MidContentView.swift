//
//  MidView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit
import SnapKit

class MidContentView: UIView {
    
    var viewModel: MainWeatherViewModel
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews
    
    private lazy var twentyFourHoursButton = {
        let button = UIButton()
        let text = "Подробнее на 24 часа"
        let attributedTitle = AttributedTitle.getUnderlineStyle(title: text,
                                                                fontSize: 16,
                                                                kern: 0.2)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var twentyFiveDaysButton = {
        let button = UIButton()
        let attributedTitle = AttributedTitle.getUnderlineStyle(title: "25 дней",
                                                                fontSize: 16,
                                                                kern: 0.2)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var hourlyWeatherCardCollectionView = {
        let collection = HourlyWeatherCardCollectionReusableView(viewModel: viewModel)
        return collection
    }()
    
    private lazy var dailyWeatherLabel = {
        let label = UILabel()
        label.text = "Ежедневный прогноз"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(dailyWeatherLabel)
        addSubview(hourlyWeatherCardCollectionView)
        addSubview(twentyFourHoursButton)
        addSubview(twentyFiveDaysButton)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        hourlyWeatherCardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(twentyFourHoursButton.snp.bottom).offset(30)
            make.bottom.equalTo(dailyWeatherLabel.snp.top).offset(-35)
            make.leading.trailing.equalToSuperview()
        }
        
        twentyFourHoursButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        dailyWeatherLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        twentyFiveDaysButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
}

extension MidContentView: WeatherObserver {
    private func updateUI(with weatherModel: WeatherViewModel) {
            guard let hourlyWeather = weatherModel.forecasts.first?.hours else { return }
            hourlyWeatherCardCollectionView.hoursWeatherData = hourlyWeather
        }

    
    func didUpdateWeather(_ weather: WeatherViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: weather)
        }
    }
}
