//
//  DetailedView.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 21.02.2021.
//

import UIKit

class DetailedView: UIView {
    lazy var hotelLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var starsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var suitsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var hotelImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        [hotelLabel,hotelImage,addressLabel,starsLabel,distanceLabel,suitsLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        hotelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hotelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        hotelLabel.font = .boldSystemFont(ofSize: 18)
        hotelLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        hotelLabel.textAlignment = .center
        hotelLabel.adjustsFontSizeToFitWidth = true
        
        hotelImage.topAnchor.constraint(equalTo: hotelLabel.bottomAnchor, constant: 20).isActive = true
        hotelImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hotelImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        hotelImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: hotelImage.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        starsLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        starsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        distanceLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 10).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        suitsLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10).isActive = true
        suitsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        suitsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
    }
    
    func setupImage(currentImage: UIImage){
        hotelImage.image = currentImage
    }
    func setupData(currentHotel: HotelData.Hotel){
        hotelLabel.text = currentHotel.name
        addressLabel.text = "Address: " + currentHotel.address!
        starsLabel.text = "Number of stars: " + String(currentHotel.stars!)
        distanceLabel.text = "Distance to the hotel: " + String(currentHotel.distance!)
        let array = currentHotel.suites_availability!.components(separatedBy: ":")
        var suits: String = ""
        for i in array{
            suits += i
            suits += " "
        }
        suitsLabel.text = "Available suits: \(suits)"
    }

}
