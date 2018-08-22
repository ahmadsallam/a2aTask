//
//  ListOfRepositoryViewContoller.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/22/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import Alamofire

class ListOfRepositoryViewContoller: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var isRequesting = false
    let userName = "whymarrh"
    var repositoryArray = [RepositoryObject]() {
        didSet {
            isRequesting = false
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getRepostoryAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //MARK: - Helping Method
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 10, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
            tableView.sendSubview(toBack: refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshListSelector), for: .valueChanged)
    }
    
    //MARK: - Selector
    
    @objc func refreshListSelector(_ sender: Any){
        guard !isRequesting else {
            return
        }
        getRepostoryAPI()
    }

    //MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setEmptyMessage(message: "Empty List", count: repositoryArray.count)
        return repositoryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if repositoryArray.count > 0 {
            let repoName = repositoryArray[indexPath.row].name
            cell.textLabel?.text = repoName
        }
        return cell
    }
    
    //MARK: API Call
    
    func getRepostoryAPI(){
        guard !isRequesting else { return }
        isRequesting = true
        refreshControl.beginRefreshing()
        tableView.setContentOffset(CGPoint.zero, animated: false)
        
        guard let url = URL(string: "\(Constant.baseURL)\(Constant.usersAPI)/\(userName)/\(Constant.reposAPI)") else {return}
        Alamofire.request(url).responseJSON { (response) in
            self.hideActivityIndicator()
            if response.error == nil {
                if let data = response.result.value as? [Any] {
                    if let repositoryArray = JSONParser.parseReposList(response: data) {
                        self.repositoryArray = repositoryArray
                    }
                }
            } else {
                guard let errorMessage = response.error else {return}
                self.showAlert(title: "Error", message: errorMessage.localizedDescription, ok: "Ok")
            }
        }
    }
    

   
}
