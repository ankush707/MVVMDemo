//
//  APIRequest.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import Foundation

protocol LoadDataProtocol: AnyObject {
    func fetchData(home: HomeModel?)
}

class APIRequest {
    
    weak var fetchDataDelegate: LoadDataProtocol?
    
    init(delegate: LoadDataProtocol) {
        self.fetchDataDelegate = delegate
    }
    
    func loadData() {
        guard let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population") else {
            print("Invalid url...")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            guard let dataObj = data else {
                print("Invalid data...")
                return
            }
            
            if let homeData = try? JSONDecoder().decode(HomeModel.self, from: dataObj) {
                DispatchQueue.main.async {
                    self.fetchDataDelegate?.fetchData(home: homeData)
                }
            }
            
        }.resume()
    }
}
