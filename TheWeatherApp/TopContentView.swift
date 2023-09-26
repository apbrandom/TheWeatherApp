//
//  TopView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 12.09.2023.
//

import UIKit
import SnapKit

class TopContentView: UIView {
    
    var viewModel: MainWeatherViewModel
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Subviews
    private lazy var dayCardView: DayCardView = {
        let view = DayCardView()
        view.layer.cornerRadius = 5
        return view
    }()

    
    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(dayCardView)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    @MainActor
    func bindToViewModel(_ viewModel: MainWeatherViewModel) async {
        if let newWeatherModel = try? await viewModel.fetchWeather() {
            updateUI(with: newWeatherModel)
        }
    }

    private func updateUI(with weatherModel: WeatherViewModel) {
        guard let nowDt = viewModel.convertDate(from: weatherModel.nowDt) else { return }
        let fact = weatherModel.fact
        let forecasts = weatherModel.forecasts
        let tempMin = forecasts.first?.parts.day.tempMin ?? 0
        let tempMax = forecasts.first?.parts.day.tempMax ?? 0
        
        self.dayCardView.tempLabel.text = "\(fact.temp)"
        self.dayCardView.sunriseLabel.text = forecasts.first?.sunrise ?? "N/A"
        self.dayCardView.sunsetLabel.text = forecasts.first?.sunset ?? "N/A"
        self.dayCardView.humidityLabel.text = "\(fact.humidity)%"
        self.dayCardView.currentDateLabel.text = nowDt
        self.dayCardView.windSpeedLabel.text = "\(fact.windSpeed)"
        self.dayCardView.tempMinMaxLabel.text = "\(tempMin)/\(tempMax)"
    }

    private func setupConstraints() {
        dayCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
