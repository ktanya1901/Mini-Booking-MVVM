//
//  DetailedViewController.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 21.02.2021.
//

import UIKit

class DetailedViewController: UIViewController {

    var detailedView = DetailedView()
    var currentHotel: HotelData.Hotel? = nil
    var pictureId: Int = 0
    private var viewModel: DetailedViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(detailedView)
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        detailedView.setupData(currentHotel: currentHotel!)

        self.viewModel = DetailedViewModel()
        self.viewModel.getCurrentImage(id: pictureId)
        self.viewModel.updateControllerImage = { [weak self] img in
            self?.detailedView.hotelImage.image = img
        }
    }
    
    private func setupView(){
        detailedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        detailedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        detailedView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
