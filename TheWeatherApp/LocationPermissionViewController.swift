//
//  LocationPermissionViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 30.09.2023.
//

import UIKit
import SnapKit

class LocationPermissionViewController: UIViewController {
    
    private lazy var themeImageView = {
        let image = UIImageView(image: .themePicture)
        return image
    }()
    
    private lazy var acceptButton = {
        let button = UIButton(type: .system)
        button.setTitle("Использовать местоположение устройства", for: .normal)
        button.backgroundColor = .themeButton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var denyButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нет, я буду добавлять локации", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
        
        locationStatus()
    }
    
    //MARK: - Actions
    @objc private func acceptButtonTapped() {

        self.dismiss(animated: true, completion: nil)
        }
    
    @objc private func denyButtonTapped() {
        print("Deny button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .tintColor
    }
    
    private func setupSubviews() {
        view.addSubview(themeImageView)
        view.addSubview(acceptButton)
        view.addSubview(denyButton)
    }
    
    private func locationStatus() {

    }
    
    private func showSettingsAlert() {
        let alertController = UIAlertController(title: "Нет доступа к геолокации",
                                                message: "Перейти в настройки и предоставить доступ?",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        themeImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(themeImageView.snp.width).multipliedBy(0.7)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(200)
            make.height.equalTo(40)
        }
        
        denyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
