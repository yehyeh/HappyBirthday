//
//  BirthdayViewController.swift
//  HappyBirthday
//
//  Created by Yehonatan Yehudai on 30/04/2024.
//

import UIKit
import SwiftUI


class BirthdayViewController: UIViewController {

    @IBOutlet weak var avatarImageVIew: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var numericImageView: UIImageView!
    @IBOutlet weak var headerTopLabel: UILabel!
    @IBOutlet weak var headerBottomLabel: UILabel!

    @IBAction func onBackTap(_ sender: Any) {
    }
    @IBAction func onAvatarTap(_ sender: Any) {
        
    }

    @IBAction func onCameraTap(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

struct MyBirthdayViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = BirthdayViewController
    var baby: Baby

    func makeUIViewController(context: Context) -> UIViewControllerType {
        BirthdayViewController(nibName: "BirthdayViewController", bundle: nil)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
