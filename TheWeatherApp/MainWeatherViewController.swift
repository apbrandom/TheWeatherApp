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
        let view = BottomContentView(viewModel: viewModel)
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        
        viewModel.addTitleObserver(self)
        viewModel.addWeatherObserver(topView)
        viewModel.addWeatherObserver(midView)
        viewModel.addWeatherObserver(bottomView)
        
        LocationService.shared.checkLocationService()
        requestPermission()
        fetchWeather()
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
        let authStatus = LocationService.shared.locationManager?.authorizationStatus
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            LocationService.shared.didUpdateLocation = { [weak self] coordinate in
                self?.viewModel.latitude = coordinate.latitude
                self?.viewModel.longitude = coordinate.longitude
            }
            
            Task {
                do {
                    _ = try await viewModel.fetchWeather(latitude: viewModel.latitude, longitude: viewModel.longitude)
                    
                    if let locationName = await viewModel.fetchLocationName() {
                        DispatchQueue.main.async {
                            self.navigationItem.title = locationName
                        }
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        } else {
            showQAlert(
                title: "Разрешение на геолокацию",
                message: "Для доступа к этой функции необходимо разрешение на использование геолокации. Перейдите в настройки, чтобы изменить разрешения.",
                action: {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    }
                })        }
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "City, Country"
        
        let leftBarItem = UIBarButtonItem(
            image: UIImage(resource: .menu),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped))
        leftBarItem.tintColor = .black
        
        let rightBarItem = UIBarButtonItem(
            image: UIImage(resource: .location),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped))
        rightBarItem.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
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
    
    func fetchWeather() {
        Task {
            do {
                _ = try await viewModel.fetchWeather(latitude: viewModel.latitude, longitude: viewModel.longitude)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func         requestPermission() {
        LocationService.shared.requestPermission = { [weak self] in
            DispatchQueue.main.async {
                let permissionVC = LocationPermissionViewController()
                self?.present(permissionVC, animated: true, completion: nil)
            }
        }
    }
    
}

extension MainWeatherViewController: TitleObservable {
    func didUpdateLocationName(_ locationName: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = locationName
        }
    }
}
