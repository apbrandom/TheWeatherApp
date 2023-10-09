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
    private lazy var tempratureGraphView = {
        let view = temperatureGraphView(viewModel: viewModel)
        return view
    }()

    // MARK: - Initialization
    
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
    
    
    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .secBackground
    }
    
    private func setupSubviews() {
        addSubview(tempratureGraphView)
    }
    
    private func setupConstraints() {
        tempratureGraphView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
