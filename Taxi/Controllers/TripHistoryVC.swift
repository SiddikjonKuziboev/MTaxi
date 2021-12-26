//
//  TripHistoryVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/19/21.
//

import UIKit

class TripHistoryVC: UIViewController {
    
    var tableView: UITableView = {
        var t = UITableView(frame: CGRect(), style: .grouped)
        t.backgroundColor = .white
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    let images: [String] = [
        "gentra",
        "nexia",
        "malibu"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        let backItem = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: .done, target: self, action: #selector(backButtonTapped))
           navigationItem.backBarButtonItem = backItem
       
        
        let navigatiol_label = UILabel(frame: CGRect(x: view.frame.width/8, y: 7, width: 250, height: 25))
        navigatiol_label.text = "Мои поездки"
        navigatiol_label.textAlignment = .left
        navigatiol_label.textColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        navigatiol_label.font = UIFont.init(name: "Lato-Black", size: 24)
        navigationController?.navigationBar.addSubview(navigatiol_label)
        print(view.frame.width/8,444)
        
    }
    
    @objc func backButtonTapped() {
        
    }
    
}

extension TripHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func setUpTableView()  {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        
        tableView.register(TripHistoryTVC.nib(), forCellReuseIdentifier: TripHistoryTVC.identifier)
        
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripHistoryTVC.identifier, for: indexPath)as! TripHistoryTVC
        cell.carImage.image = UIImage(named: images[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TripDetailVC(nibName: "TripDetailVC", bundle: nil)
        
        navigationController?.pushViewController(vc, animated:  true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 49))
        v.backgroundColor = .clear
        
        
        //Label 1
        let dateLabel = UILabel(frame: CGRect(x: 16, y: 14, width: 120, height: 25))
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "6 Июля, Вторник"
        dateLabel.font = UIFont.init(name: "Lato-Black", size: 24)
        dateLabel.textColor =  #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        dateLabel.textAlignment = .left
        
        
        let insideView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .white
            return v
        }()
        
        v.addSubview(insideView)
        
        
        insideView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        insideView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: +6).isActive = true
        insideView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0).isActive = true
        
        insideView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0).isActive = true
        
        insideView.addSubview(dateLabel)
        
        dateLabel.leftAnchor.constraint(equalTo: insideView.leftAnchor, constant: 16).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: insideView.centerYAnchor, constant: 0).isActive = true
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        137
    }
    
}
