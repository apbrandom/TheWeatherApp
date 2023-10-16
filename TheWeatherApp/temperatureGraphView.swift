//
//  temperatureGraphView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 05.10.2023.
//

import UIKit

class temperatureGraphView: UIView {
    
    //MARK: - Properties
    var temperatures: [Int] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    func setupView() {
        backgroundColor = .clear
    }
    
    //MARK: - GraphView
    override func draw(_ rect: CGRect) {
        
        guard !temperatures.isEmpty, let context = UIGraphicsGetCurrentContext() else { return }
        
        // Настроим параметры линии
        context.setStrokeColor(UIColor.tintColor.cgColor)
        context.setLineWidth(1)
        
        // Начальные координаты
        let startPoint = CGPoint(x: 16, y: rect.height - CGFloat(temperatures[0]))
        
        context.move(to: startPoint)
        
        // Рассчитаем шаг между точками на оси X
        let stepX = (rect.width - 40) / CGFloat(temperatures.count - 1)
        
        for (index, temperature) in temperatures.enumerated() {
            let x = CGFloat(index) * stepX + 20
            let y = rect.height - CGFloat(temperature)
            
            // Рисуем линию к точке
            context.addLine(to: CGPoint(x: x, y: y))
            
            // Рисуем кружок вокруг точки
            context.addEllipse(in: CGRect(x: x - 1.5, y: y - 1.5, width: 3, height: 3))
            
            // Добавляем температурные показатели над каждой точкой
            let temperatureString = "\(temperature)"
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            
            let size = temperatureString.size(withAttributes: attributes)
            let labelX = x - size.width / 2
            let labelY = y - size.height - 5
            
            temperatureString.draw(in: CGRect(x: labelX, y: labelY, width: size.width, height: size.height), withAttributes: attributes)
            
            // Перемещаем "карандаш" обратно к концу линии (не обязательно)
            context.move(to: CGPoint(x: x, y: y))
        }
        
        context.strokePath()
    }
}
