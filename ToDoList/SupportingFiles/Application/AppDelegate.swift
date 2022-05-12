//
//  AppDelegate.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let di = DI()
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        rootVC.navigationBar.tintColor = .systemGray
        window?.rootViewController = rootVC
        coordinator = di.makeAppCoordinator(navigationController: rootVC)
        coordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
