//
//  ViewControllerPresenter.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import Foundation
import UIKit

typealias PresenterDelegate = UserDataProtocol & UIViewController & UINavigationBarDelegate

protocol UserDataProtocol: AnyObject {
    
    func loadData(home: HomeModel?)
}


class ViewControllerPresenter: LoadDataProtocol {
    
    
    weak private var delegate : PresenterDelegate?
    var requestObj: APIRequest?
    
    var homeObj: HomeModel?
    
    init() {
        self.requestObj = APIRequest(delegate: self)
    }
    
    func setViewDelegate(delegate:PresenterDelegate?){
            self.delegate = delegate
        }
  
    public func getUsers() {
        self.requestObj?.loadData()
    }
    
    internal func fetchData(home: HomeModel?) {
        self.delegate?.loadData(home: home)
        
        
    }
    
    public func showAlert(msg: String) {
        self.presentAlertWithMessage(msg: msg)
    }
    
    public func presentAlertWithMessage(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
        self.delegate?.present(alert, animated: true)
    }
}
