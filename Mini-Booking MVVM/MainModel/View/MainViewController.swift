//
//  MainViewController.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 19.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    var mainView = MainView()
    private var viewModel: MainViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Available Hotels"
        
        mainView.delegate = self
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        self.viewModel = MainViewModel()
        self.viewModel.startFetch()

        self.viewModel.updateViewData = { [weak self] data in
            self?.mainView.viewData = data
        }
        
        self.viewModel.updateImage = { [weak self] img, indexPath in
            self?.mainView.setImage(img: img, indexPath: indexPath)
        }
    }
    
    private func setupView(){
        mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


}

extension MainViewController: MainViewProtocol{
    func getImage(indexPath: IndexPath) {
        self.viewModel.getImage(indexPath: indexPath)
    }
    
    func getDetailedView(indexPath: IndexPath){
        let hoteldata: HotelData.Hotel = self.mainView.hotelData[indexPath.row]
        let detailedVC = DetailedViewController()
        detailedVC.currentHotel = hoteldata
        detailedVC.pictureId = indexPath.row+1
        self.navigationController!.pushViewController(detailedVC, animated: true)
    }
}

