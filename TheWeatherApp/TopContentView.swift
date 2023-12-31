//
//  TopView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 12.09.2023.
//

import UIKit
import SnapKit

class TopContentView: UIView {
    
    //MARK: - Properties
    var viewModel: WeatherViewModel
    
    // MARK: - Subviews
    private lazy var dayCardView: DayCardView = {
        let view = DayCardView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    //MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(dayCardView)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        dayCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}

// MARK: - WeatherObserver
extension TopContentView: WeatherObserver {
    internal func didUpdateWeather(_ weatherModel: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: weatherModel)
        }
    }
    
    internal func updateUI(with weatherModel: WeatherModel) {
        guard let nowDt = ToolsService.convertDateWithFormater(from: weatherModel.nowDt) else { return }
        let fact = weatherModel.fact
        let forecasts = weatherModel.forecasts
        let tempMin = forecasts.first?.parts.day.tempMin ?? 0
        let tempMax = forecasts.first?.parts.day.tempMax ?? 0
        let chanceOfRain = forecasts.first?.parts.day.precProb ?? 0
        let condition = viewModel.getWeatherCondition()
        
        dayCardView.tempLabel.text = "\(fact.temp)\u{00B0}"
        dayCardView.sunriseLabel.text = forecasts.first?.sunrise ?? "N/A"
        dayCardView.sunsetLabel.text = forecasts.first?.sunset ?? "N/A"
        dayCardView.humidityLabel.text = "\(fact.humidity)%"
        dayCardView.currentDateLabel.text = nowDt
        dayCardView.windSpeedLabel.text = "\(fact.windSpeed)"
        dayCardView.tempMinMaxLabel.text = "\(tempMin)\u{00B0}/\(tempMax)\u{00B0}"
        dayCardView.condintionLabel.text = condition
        dayCardView.chanceOfRainLabel.text = "\(chanceOfRain)%"
    }
}
