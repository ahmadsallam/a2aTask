//
//  RepositoryDetailsViewController.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/24/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var numberOfWatchersLabel: UILabel!
    
    var repositoryName: String!
    var numberOfForks: String!
    var numberOfWatcher: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Init
    init(repositoryName: String,numberOfForks: Int,numberOfWatcher: Int){
        self.repositoryName = repositoryName
        self.numberOfForks = "\(numberOfForks)"
        self.numberOfWatcher = "\(numberOfWatcher)"
        super.init(nibName: "RepositoryDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Helping Methods
    
    func setupView(){
        view.backgroundColor = .clear
        exitButton.addTarget(self, action: #selector(dismissButtonSelector), for: .touchUpInside)
        
        //Adding tapGesture for close the presented view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureSelector(sender:)))
        overlayView.addGestureRecognizer(tapGesture)
        
        repositoryNameLabel.text = repositoryName
        numberOfForksLabel.text = numberOfForks
        numberOfWatchersLabel.text = numberOfWatcher
    }

    
    @objc func tapGestureSelector(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func dismissButtonSelector(){
        dismiss(animated: true, completion: nil)
    }

}
