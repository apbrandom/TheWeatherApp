//
//  DetailWeatherViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.09.2023.
//

import UIKit
import SnapKit

class DetailWeatherViewController: UITableViewController {
    
    //MARK: - Properties
    var viewModel: WeatherViewModel
    
    //MARK: - initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped) // или .plain, в зависимости от нужного стиля
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        setupTableView()
        
        viewModel.addWeatherObserver(self)
        
        Task {
            await viewModel.fetchDataAndUpdateUI()
        }
    }
    
    //MARK: - Setup Methods
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupTableView() {
        view.backgroundColor = .white
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: HourlyTableViewCell.reuseIdentifier)
    }
    
    //MARK: - TablewView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HourlyWeatherHeaderView(viewModel: viewModel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherForecasts.first??.hours.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.reuseIdentifier, for: indexPath) as! HourlyTableViewCell
        
        let hour = viewModel.weatherForecasts.first??.hours[indexPath.row]
        cell.configure(with: hour)
        return cell
    }
    

}

     //MARK: - Observer
extension DetailWeatherViewController: WeatherObserver {
    func didUpdateWeather(_ weather: WeatherModel) {

    }
    
    func updateUI(with weather: WeatherModel) {
        
    }
}

