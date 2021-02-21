//
//  MainView.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 19.02.2021.
//

import Foundation
import UIKit

protocol MainViewProtocol {
    func getImage(indexPath: IndexPath)
    func getDetailedView(indexPath: IndexPath)
}

class MainView: UIView{
    lazy var sortButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let tableView = UITableView()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    
    var delegate: MainViewProtocol!
    var hotelData: [HotelData.Hotel] = []

    var viewData: HotelData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        [tableView, sortButton, activityIndicator].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        
        sortButton.addTarget(self, action: #selector(sortByScore), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(viewData: [HotelData.Hotel], isHidden: Bool) {
        if isHidden {
            self.tableView.isHidden = true
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        } else {
            
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.setupTable(data: viewData)
        }
    }
    
    func setImage(img: UIImage, indexPath: IndexPath){
        DispatchQueue.main.async(execute: {
            let updateCell = self.tableView.cellForRow(at: indexPath) as? MainTableViewCell
            if updateCell != nil{
                updateCell?.hotelImageView.image = img
            }
        })
    }

    
    func setupTable(data: [HotelData.Hotel]){
        hotelData = data
        self.tableView.reloadData()
    }
    
    private func setupViews(){
        sortButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sortButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sortButton.backgroundColor = .blue
        sortButton.setTitle("Sort by score", for: .normal)
        
        tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "HotelCell")
    }
    
    @objc func sortByScore(){
        self.hotelData.sort {
            $0.stars! > $1.stars!
        }
        self.tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            self.update(viewData: [], isHidden: true)
        case .loading(let loading):
            self.update(viewData: loading, isHidden: true)
        case .success(let success):
            self.update(viewData: success, isHidden: false)
        case .error(let error):
            self.update(viewData: error, isHidden: false)
        }
    }

}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCell", for: indexPath) as! MainTableViewCell
        cell.hotelLabel.text = hotelData[indexPath.row].name
        cell.addressLabel.text = hotelData[indexPath.row].address
        cell.scoreLabel.text =  String(hotelData[indexPath.row].stars!)
        
        self.delegate.getImage(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.getDetailedView(indexPath: indexPath)
    }
}
