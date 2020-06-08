//
//  TaskCell.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 02/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    open var task: Task? {
        didSet {
            guard let name = task?.name else { return }
            guard let category = task?.category else { return }
            guard let date = task?.date else { return }

            // set text in labels
            
            dateLabel.text = date.toMediumString()
            nameLabel.text = name
            categoryLabel.text = category
        }
    }
              
   fileprivate var nameLabel: UILabel = {
       let label = UILabel()
       label.textColor = UIColor(red: 255/255, green: 121/255, blue: 121/255, alpha: 1)
       label.font = UIFont.boldSystemFont(ofSize: 16)
       return label
   }()
   
   fileprivate var categoryLabel: UILabel = {
       let label = UILabel()
       label.textColor = UIColor(red: 104/255, green: 109/255, blue: 224/255, alpha: 1)
       label.font = UIFont.boldSystemFont(ofSize: 16)
       return label
   }()
   
   fileprivate var dateLabel: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.font = UIFont.systemFont(ofSize: 11)
       return label
   }()
    
    internal override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray5
            
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(dateLabel)
        
        nameLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, paddingTop: 5, paddingBottom: 5, paddingLeft: 5, paddingRight: 0, width: 0, height: 0)
        categoryLabel.anchor(top: nil, bottom: nil, left: nil, right: rightAnchor, paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 5, width: 0, height: 0)
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        dateLabel.anchor(top: categoryLabel.bottomAnchor, bottom: bottomAnchor, left: nil, right: rightAnchor, paddingTop: 5, paddingBottom: 5, paddingLeft: 5, paddingRight: 5, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
