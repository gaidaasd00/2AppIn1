//
//  MainViewController.swift
//  2AppIn1
//
//  Created by Алексей Гайдуков on 28.07.2022.
//

import UIKit

protocol ColorAppViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let colorAppVC = segue.destination as? ColorAppViewController else { return }
            colorAppVC.delegate = self
            colorAppVC.viewColor = view.backgroundColor
        }
    }
    


}

//MARK: ColorDelegate
extension MainViewController: ColorAppViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

