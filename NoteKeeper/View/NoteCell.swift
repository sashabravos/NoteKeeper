//
//  NoteCell.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 26.06.2023.
//

import UIKit

class NoteCell: UITableViewCell {
    
    let taskNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Keys.Colors.primaryTextColor
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let checkmark: UIImageView = {
        let check = UIImageView()
        check.tintColor = .black
        check.contentMode = .scaleAspectFill
        return check
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI(contentView)
        contentView.backgroundColor = Keys.Colors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ view: UIView) {
        
        let cellStack = UIStackView()
        cellStack.alignment = .center
        cellStack.axis = .horizontal
        cellStack.spacing = 10
        
        [checkmark, taskNameLabel, cellStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [checkmark, taskNameLabel].forEach {
            cellStack.addArrangedSubview($0)
        }
        
        view.addSubview(cellStack)
        
        NSLayoutConstraint.activate([
            
            checkmark.widthAnchor.constraint(equalToConstant: 30),
            checkmark.heightAnchor.constraint(equalToConstant: 30),
            
            cellStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 5),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -5),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 10),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -10),
            cellStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
}
