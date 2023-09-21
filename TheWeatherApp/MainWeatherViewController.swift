//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.09.2023.
//

import UIKit
import SnapKit
import Combine

class MainWeatherViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    var viewModel: MainWeatherViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
        let view = TopContentView()
        return view
    }()
    
    private lazy var midView: MidContentView = {
        let view = MidContentView()
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
        setupNavgatoinBar()
        setupConstraints()
        bindViewModel()
        
        Task { [weak self] in
            await self?.viewModel.fetchWeather()
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
    
    func bindViewModel() {
        topView.bindToViewModel(viewModel)
    }
    
    private func setupNavgatoinBar() {
        navigationItem.title = "City, Country"
        
        
        //        let customTitleView = NavigationTitleView()
        //
        //        navigationItem.titleView = customTitleView
        
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
        
        navigationItem.leftBarButtonItem?.tintColor = .text
        navigationItem.rightBarButtonItem?.tintColor = .text
        
        //        let dotsProgressBar = DotsProgressBar()
        //            dotsProgressBar.numberOfDots = 2
        //            navigationItem.titleView = dotsProgressBar
        
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

