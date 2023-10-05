//
//  temperatureGraphView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 05.10.2023.
//

import UIKit

class temperatureGraphView: UIView {
    let temperatures = [25, 18, 22, 27, 29, 20, 17]
        
        override func draw(_ rect: CGRect) {
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            // Настроим параметры линии
            context.setStrokeColor(UIColor.blue.cgColor)
            context.setLineWidth(2)
            
            // Начальные координаты
            let startPoint = CGPoint(x: 20, y: rect.height - CGFloat(temperatures[0]))
            
            context.move(to: startPoint)
            
            // Рассчитаем шаг между точками на оси X
            let stepX = (rect.width - 40) / CGFloat(temperatures.count - 1)
            
            for (index, temperature) in temperatures.enumerated() {
                let x = CGFloat(index) * stepX + 20
                let y = rect.height - CGFloat(temperature)
                
                context.addLine(to: CGPoint(x: x, y: y))
                context.move(to: CGPoint(x: x, y: y))
                
                // Рисуем кружок вокруг точки
                context.addEllipse(in: CGRect(x: x - 5, y: y - 5, width: 10, height: 10))
            }
            
            context.strokePath()
        }

}
