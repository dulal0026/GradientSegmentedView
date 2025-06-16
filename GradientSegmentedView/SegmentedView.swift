//
//  SegmentedView.swift
//  GradientSegmentedView
//
//  Created by Dulal Hossain on 17/6/25.
//
import UIKit

class SegmentedView: UIView {
    
    var didSelectItem:(Int)-> Void = { _ in }
    
    var viewModel: SegmentedViewModel?{
        didSet {
            reloadData()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()
    
    var stackView: UIStackView = {
        let stcView: UIStackView = UIStackView(frame: .zero)
        stcView.translatesAutoresizingMaskIntoConstraints = false
        stcView.axis = .horizontal
        stcView.distribution = .fillEqually
        stcView.spacing = 4
        return stcView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGradientBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupGradientBorder()
    }
    
    private func setupViews() {
        self.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupGradientBorder() {
        gradientLayer.colors = [
            UIColor(hex: "#E1A63E").cgColor,
            UIColor(hex: "#7B5B22").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        
        shapeLayer.lineWidth = 4
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor // will be masked by gradient
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 2, dy: 2), cornerRadius: 8)
        shapeLayer.path = path.cgPath
        
        gradientLayer.mask = shapeLayer
        
        layer.addSublayer(gradientLayer)
        self.backgroundColor = .black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 2, dy: 2), cornerRadius: 8)
        shapeLayer.path = path.cgPath
        
        self.layer.cornerRadius = 8.0
    }
    
    func reloadData() {
        guard let viewModel = viewModel else { return }
        for index in 0..<viewModel.items.count {
            let itemView = SegmentedItemView()
            itemView.tag = index
            stackView.addArrangedSubview(itemView)
            
            itemView.isUserInteractionEnabled = true
            let tapG = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            itemView.addGestureRecognizer(tapG)
            
            itemView.viewModel = .init(title: viewModel.items[index],
                                       selected: viewModel.selectedIndex == index)
        }
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        guard let viewModel = viewModel else {
            return
        }
        let taag = sender.view?.tag ?? 0
        viewModel.selectedIndex = taag
      
        for index in 0..<stackView.arrangedSubviews.count {
            if let itemView: SegmentedItemView = stackView.arrangedSubviews[index] as? SegmentedItemView {
                itemView.viewModel?.isSelected = taag == index
                itemView.updateSelection()
            }
        }
        didSelectItem(viewModel.selectedIndex)
    }
    
}
