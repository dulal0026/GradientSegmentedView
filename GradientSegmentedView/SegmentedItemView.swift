//
//  SegmentedItemView.swift
//  GradientSegmentedView
//
//  Created by Dulal Hossain on 17/6/25.
//

import UIKit

class SegmentedItemViewModel {
    var title: String
    var isSelected: Bool
    
    init(title: String, selected: Bool) {
        self.title = title
        isSelected = selected
    }
    
    var titleColor: UIColor {
        isSelected ? UIColor(hex: "#000000") : UIColor(hex: "#E2A93C")
    }
}

class SegmentedItemView: UIView {
    
    var didSelectItem: ()->Void = {}
    
    var viewModel: SegmentedItemViewModel? {
        didSet {
            configure()
        }
    }
    
    var label: UILabel = {
        let vew: UILabel = UILabel(frame: .zero)
        vew.textAlignment = .center
        vew.font = .boldSystemFont(ofSize: 18)
        vew.translatesAutoresizingMaskIntoConstraints = false
        return vew
    }()
    
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.layer.cornerRadius = 8.0

        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        
        self.layer.cornerRadius = 8.0
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        label.text = viewModel.title
        updateSelection()
    }
    
    func updateSelection() {
        guard let viewModel = viewModel else { return }

        label.textColor = viewModel.titleColor
        
        if viewModel.isSelected {
            gradientLayer.colors = [
                UIColor(hex: "#7C5D21").cgColor,
                UIColor(hex: "#E2A93C").cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = bounds
            
            layer.insertSublayer(gradientLayer, at: 0)
            
        } else {
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.clear.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = bounds
            
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
