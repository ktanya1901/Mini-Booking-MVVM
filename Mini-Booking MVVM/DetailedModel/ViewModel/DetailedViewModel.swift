//
//  DetailedViewModel.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 21.02.2021.
//

import Foundation
import Moya
import UIKit

protocol DetailedViewModelProtocol{
    var updateControllerImage: ((UIImage)->())? {get set}
    func getCurrentImage(id: Int)
}

final class DetailedViewModel: DetailedViewModelProtocol{
    var updateControllerImage: ((UIImage) -> ())?
    let provider = MoyaProvider<APIService>()
    
    func getCurrentImage(id: Int){
        provider.request(.getHotelPicture(id: id)) { [weak self] result in
            switch result{
            case .success(let response):
                var image: UIImage? = nil
                image = UIImage(data: response.data)
                if image != nil{
                    self?.updateControllerImage?(image!)
                }
            case .failure:
                print("Error loading the image")
            }
        }
    }
}
