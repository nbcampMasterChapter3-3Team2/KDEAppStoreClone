//
//  HomeViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let homeView = HomeView()

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
