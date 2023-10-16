//
//  BottomContentView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit

class BottomContentView: UIView {
    
    //MARK: - Properties
    var viewModel: WeatherViewModel
    
    // MARK: - Subviews
    private lazy var dailyWeatherCollectionView = {
        let collection = DailyWeatherCollectionReusableView(viewModel: viewModel)
        return collection
    }()
    
    // MARK: - Initializers
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
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(dailyWeatherCollectionView)
    }
    
    private func setupConstraints() {
        dailyWeatherCollectionView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

//MARK: - WeahterObserver
extension BottomContentView: WeatherObserver {
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: weather)
        }
    }
    internal func updateUI(with weatherModel: WeatherModel) {
        let dailyWeather = weatherModel.forecasts 
        dailyWeatherCollectionView.dailyWeatherData = dailyWeather
    }
}
