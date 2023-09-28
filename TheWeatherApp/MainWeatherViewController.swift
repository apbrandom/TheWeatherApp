//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.09.2023.
//

import UIKit
import SnapKit

class MainWeatherViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    var viewModel: MainWeatherViewModel
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var topView: TopContentView = {
        let view = TopContentView(viewModel: viewModel)
        return view
    }()
    
    private lazy var midView: MidContentView = {
        let view = MidContentView(viewModel: viewModel)
        return view
    }()
    
    private lazy var bottomView: BottomContentView = {
        let view = BottomContentView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        
        viewModel.addObserver(topView)
        viewModel.addObserver(midView)
        viewModel.addObserver(bottomView)
        
        Task {
            do {
                _ = try await viewModel.fetchWeather()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        adjustSubviews()
    }
    
    //MARK: - Actions
    
    @objc func leftBarButtonTapped() {
        // Ваш код при нажатии на левую кнопку
    }
    
    @objc func rightBarButtonTapped() {
        // Ваш код при нажатии на правую кнопку
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func adjustSubviews() {
        let dimension = view.window?.windowScene?.interfaceOrientation.isPortrait == true ?
        mainScrollView.frame.size.height : mainScrollView.frame.size.width
        
        viewModel.fixedHeightSubviews = dimension / viewModel.getNumberOfSubviews()
        
        mainStackView.arrangedSubviews.forEach { view in
            view.snp.updateConstraints { make in
                make.height.equalTo(viewModel.getFixedHeightSubviews())
            }
        }
    }
    
    private func setupSubviews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(midView)
        mainStackView.addArrangedSubview(bottomView)
    }
    
    private func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView)
        }
    }
}

