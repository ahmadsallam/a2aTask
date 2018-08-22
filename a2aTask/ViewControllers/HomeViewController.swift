//
//  HomeViewController.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/19/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import Pastel
import Alamofire

class HomeViewController: UIViewController {
   
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var numberOfReposLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listOfReposButton: UIButton!
    @IBOutlet weak var loadingActivityImage: UIActivityIndicatorView!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var imageRoundedView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var innerSepratorView: UIView!
    
    let userName = "whymarrh"
    var userObject = UserObject() {
        didSet {
            nameLabel.text = userObject.name
            numberOfReposLabel.text = "\(userObject.public_repos ?? 0)"
            downloadImage(url: userObject.avatar_url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfReposButton.addTarget(self, action: #selector(listOfReposButtonSelector), for: .touchUpInside)
        getUserDataAPI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        setupImageView()
        animationSepratorView(forView: innerSepratorView)
        animationSepratorView(forView: sepratorView)
    }
    
    //MARK: - Selector And Action
    
    @objc func listOfReposButtonSelector(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ListOfRepositoryViewContoller") as? ListOfRepositoryViewContoller else {return}
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Helping Method
    
    func setupImageView(){
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageRoundedView.layer.cornerRadius = imageRoundedView.bounds.width / 2
        imageRoundedView.backgroundColor = .white
    }

    func animationSepratorView(forView: UIView){
        let pastelView = PastelView(frame: forView.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        // Custom Duration
        pastelView.animationDuration = 3.0
        // Custom Color
        pastelView.setColors(Constant.colrsArray)
        pastelView.startAnimation()
        forView.insertSubview(pastelView, at: 0)
    }
    
    //MARK: - API Requst
    
    func downloadImage(url:String?){
        guard let url = url else {return}
        self.imageIndicator.startAnimating()
        Alamofire.request(url).responseData { (response) in
            self.imageIndicator.stopAnimating()
            self.imageIndicator.isHidden = true
            if response.error == nil {
                if let data = response.data {
                    self.imageView.image = UIImage(data: data)
                }
            } else {
                guard let errorMessage = response.error else {return}
                self.showAlert(title: "Error", message: errorMessage.localizedDescription, ok: "Ok")
            }
        }
    }
    
    func getUserDataAPI() {
        guard let url = URL(string: "\(Constant.baseURL)\(Constant.usersAPI)/\(userName)") else {return}
        showActivityIndicator()
        Alamofire.request(url).responseJSON { (response) in
            self.hideActivityIndicator()
            if response.error == nil {
                if let data = response.result.value as? [String:Any] {
                    if let user = JSONParser.parseUserObject(response: data) {
                        self.userObject = user
                    }
                }
            } else {
                guard let errorMessage = response.error else {return}
                self.showAlert(title: "Error", message: errorMessage.localizedDescription, ok: "Ok")
            }
        }
    }
    
}
