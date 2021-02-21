//
//  MainTableViewCell.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 20.02.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    lazy var hotelImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    lazy var hotelLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white
        [hotelImageView,hotelLabel,addressLabel,scoreLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupViews()
    }
    
    private func setupViews(){
        hotelImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        hotelImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        hotelImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        hotelImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        hotelLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor,constant: 5).isActive = true
        hotelLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        hotelLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        hotelLabel.font = .boldSystemFont(ofSize: 12)
        
        addressLabel.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor,constant: 5).isActive = true
        addressLabel.topAnchor.constraint(equalTo: hotelLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addressLabel.font = .italicSystemFont(ofSize: 10)
        
        scoreLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -5).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        scoreLabel.font = .boldSystemFont(ofSize: 12)
        scoreLabel.backgroundColor = .systemYellow
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
