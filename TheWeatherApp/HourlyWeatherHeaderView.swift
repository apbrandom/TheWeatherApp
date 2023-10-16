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
    
    private lazy var hourlyWeatherCollectionView = {
        let collection = HourlyWeatherCollectionReusableView(viewModel: viewModel)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
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
        addSubview(hourlyWeatherCollectionView)
    }
    
    private func setupConstraints() {
        tempGraphView.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        hourlyWeatherCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(tempGraphView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
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
        hourlyWeatherCollectionView.hourlyWeatherData = hourModel
  
        var tempResult: [Int] = []

        //Get data only for every 3 hours
        for i in stride(from: 0, through: hourModel.count, by: 3) {
            if i < hourModel.count {
                let temp = hourModel[i].temp
                tempResult.append(temp)
            }
          
            tempGraphView.temperatures = tempResult
            tempGraphView.setNeedsDisplay()
        }
    }
}
