//
//  TasksListTableViewCell.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

final class TasksListTableViewCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let reuseID = "ToDoTableViewCell"
    
    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.3) {
            self.transform = highlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
        }
    }
    
    // MARK: - Private methods
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.regular),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    }
    
    private func layoutDetailLabel() {
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: Padding.regular),
            detailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.regular)
        ])
        
        
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "background")
        
        layoutTitleLabel()
        layoutDetailLabel()
    }
    
    // MARK: - Methods
    
    func configure(with tasksList: TasksList?) {
        guard let tasksList = tasksList else { return }
        
        titleLabel.text = tasksList.name
        detailLabel.text = tasksList.isCompleted ? "✓" : "\(tasksList.currentTasks.count)"
    }
}

