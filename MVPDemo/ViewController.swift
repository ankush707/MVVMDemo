//
//  ViewController.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import UIKit

class ViewController: UIViewController, UINavigationBarDelegate, UserDataProtocol {

    lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50), style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .cyan
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    var delegate: ViewControllerPresenter = ViewControllerPresenter()
    
    var homeObj: HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .cyan
        self.view.addSubview(tableView)
        self.delegate.setViewDelegate(delegate: self)
        self.delegate.getUsers()
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeObj?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        if let currentObject = homeObj?.data?[indexPath.row] {
            cell.textLabel?.text = "\(currentObject.nation) has population of \(currentObject.population) in year \(currentObject.year)."
            cell.textLabel?.numberOfLines = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentObject = homeObj?.data?[indexPath.row] {
            self.delegate.presentAlertWithMessage(msg: "\(currentObject.nation) has population of \(currentObject.population) in year \(currentObject.year).")
        }
    }
    
}

extension ViewController {
    func loadData(home: HomeModel?) {
        self.homeObj = home
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
