//
//  TopView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 12.09.2023.
//

import UIKit
import SnapKit
import Combine

class TopContentView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Subviews
    private lazy var dayCardView: DayCardView = {
        let view = DayCardView()
        view.layer.cornerRadius = 5
        return view
    }()
        
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    func bindToViewModel(_ viewModel: MainWeatherViewModel) {
        viewModel.$weatherModel
            .sink { [weak self] newWeatherModel in
                DispatchQueue.main.async {
                    if let temp = newWeatherModel?.fact.temp {
                        self?.dayCardView.tempLabel.text = "\(temp)"
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func setupConstraints() {
        dayCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
