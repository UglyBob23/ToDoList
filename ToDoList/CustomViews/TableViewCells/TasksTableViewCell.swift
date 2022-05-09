//
//  TasksTableViewCell.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

final class TasksTableViewCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let reuseID = "TasksTableViewCell"

    // MARK: - Private properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
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
    
    // MARK: - Private methods
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.compact),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.regular),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.regular)
        ])
    }
    
    private func layoutDetailLabel() {
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.compact),
            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.compact)
        ])
    }
    
    private func setupUI() {
        layoutTitleLabel()
        layoutDetailLabel()
    }
    
    
    // MARK: - Methods
    
    func configure(with task: Task?) {
        guard let task = task else { return }
        
        titleLabel.text = task.name
        detailLabel.text = task.note
    }
}
