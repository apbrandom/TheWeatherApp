//
//  HourlyWeatherHeaderView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 07.10.2023.
//

import UIKit
import SnapKit

class HourlyWeatherHeaderView: UIView {
    
    //MARK: - Propreties
    var viewModel: WeatherViewModel
    
    //MARK: - Subview
    private lazy var tempGraphView = {
        let view = temperatureGraphView()
        return view
    }()
    
    private lazy var conditionIconImageView = {
        let imageView = UIImageView()
        imageView.image = .sun
        return imageView
    }()

    // MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupConstraints()
        viewModel.addWeatherObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .secBackground
    }
    
    private func setupSubviews() {
        addSubview(tempGraphView)
    }
    
    private func setupConstraints() {
        tempGraphView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}

//MARK: - WeatherObserver
extension HourlyWeatherHeaderView: WeatherObserver {
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: weather)
        }
    }
    
    func updateUI(with weather: WeatherModel) {
        guard let hourModel = viewModel.weatherForecasts.first??.hours else { return }
        var tempResult: [Int] = []
        var conditionResult: [String] = []
        var hourResult: [String] = []
        
        for i in stride(from: 0, through: hourModel.count, by: 3) {
            if i < hourModel.count {
                let temp = hourModel[i].temp
                let cond = hourModel[i].condition
                let hour = hourModel[i].hour
                
                tempResult.append(temp)
                conditionResult.append(cond)
                hourResult.append(hour)
            }
            
            
            tempGraphView.temperatures = tempResult
            
            tempGraphView.setNeedsDisplay()
        }
    }
}
