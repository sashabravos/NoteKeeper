//
//  CategoryCell.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 26.06.2023.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    let taskNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = Keys.Colors.primaryTextColor
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    let tasksCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Keys.Colors.secondaryTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let arrowView: UIImageView = {
        let arrow = UIImageView()
        arrow.image = Keys.Images.arrowImage
        arrow.tintColor = Keys.Colors.primaryTextColor
        return arrow
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ view: UIView) {
        
        let labelStackView = UIStackView()
 
        labelStackView.alignment = .leading
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        
        [taskNameLabel, tasksCountLabel, labelStackView, arrowView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [taskNameLabel, tasksCountLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [labelStackView, arrowView].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            labelStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            labelStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            arrowView.widthAnchor.constraint(equalToConstant: 30),
            arrowView.heightAnchor.constraint(equalToConstant: 30),
            arrowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            arrowView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
