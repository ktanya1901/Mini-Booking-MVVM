//
//  MainViewModel.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 19.02.2021.
//

import Foundation
import Moya
import UIKit

protocol MainViewModelProtocol{
    var updateViewData: ((HotelData)->())? { get set }
    var updateImage: ((UIImage, IndexPath)->())? {get set}
    func getImage(indexPath: IndexPath)
    func startFetch()
}

final class MainViewModel: MainViewModelProtocol{
    var updateImage: ((UIImage, IndexPath) -> ())?
    var updateViewData: ((HotelData) -> ())?
    
    let provider = MoyaProvider<APIService>()
    
    init() {
        updateViewData?(.initial)
    }
    
    func startFetch() {
        updateViewData?(.loading([]))
        makeHotelsRequest()
    }

    func getImage(indexPath: IndexPath){
        provider.request(.getHotelPicture(id: indexPath.row+1)) { [weak self] result in
            switch result{
            case .success(let response):
                var image: UIImage? = nil
                image = UIImage(data: response.data)
                if image != nil{
                    self?.updateImage?(image!,indexPath)
                }
            case .failure:
                print("Error loading the image")
            }
        }
    }
    
    private func makeHotelsRequest(){
        provider.request(.getHotelsList) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                do{
                    let hotelsResponse = try JSONDecoder().decode([HotelData.Hotel].self, from: response.data)
                    self.updateViewData?(.success(hotelsResponse))
                } catch {
                    // error in parsing
                    self.updateViewData?(.error([]))
                }
            case .failure:
                self.updateViewData?(.error([]))
            }
        }
    }
    
}
