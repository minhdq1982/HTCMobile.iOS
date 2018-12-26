//
//  AppDelegate.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/24/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import Rswift
import IQKeyboardManagerSwift
import SideMenu
import DropDown
import GoogleMaps
import Firebase
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbar: HTCCustomTabBarController?
    
    let cars: Variable<[CarModel]> = Variable([])
    let agencies: Variable<[AgencyLocationModel]> = Variable([])
    let cities: Variable<[CityModel]> = Variable([])
    var setting: SettingsModel?

    func createTabbarControler() -> HTCCustomTabBarController {
        let tabbarController = HTCCustomTabBarController()
        tabbarController.tabBar.tintColor = Colours.tabbarTextColor

        guard let homeVC = R.storyboard.home.homeViewController(),
            let carsVC = R.storyboard.cars.carsViewController(),
            let serviceVC = R.storyboard.services.servicesViewController(),
            let newsVC = R.storyboard.news.newsViewController(),
            let supportVC = R.storyboard.support.supportViewController()
            else {return tabbarController}

        homeVC.title = tr(L10n.homeTitle).uppercased()
        carsVC.title = tr(L10n.carsTitle).uppercased()
        serviceVC.title = ""
        newsVC.title = tr(L10n.newsTitle).uppercased()
        supportVC.title = tr(L10n.supportTitle).uppercased()

        homeVC.tabBarItem = UITabBarItem(title: tr(L10n.homeTitle).uppercased(), image: R.image.home()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.home_selected()?.withRenderingMode(.alwaysOriginal))
        carsVC.tabBarItem = UITabBarItem(title: tr(L10n.carsTitle).uppercased(), image: R.image.cars()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.cars_selected()?.withRenderingMode(.alwaysOriginal))
        serviceVC.tabBarItem = UITabBarItem(title: tr(L10n.servicesTitle).uppercased(), image: R.image.services()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.services_selected()?.withRenderingMode(.alwaysOriginal))
        newsVC.tabBarItem = UITabBarItem(title: tr(L10n.newsTitle).uppercased(), image: R.image.news()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.news_selected()?.withRenderingMode(.alwaysOriginal))
        supportVC.tabBarItem = UITabBarItem(title: tr(L10n.supportTitle).uppercased(), image: R.image.support()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.support_selected()?.withRenderingMode(.alwaysOriginal))

        let homeNav = UINavigationController(rootViewController: homeVC)
        let carsNav = UINavigationController(rootViewController: carsVC)
        let servicesNav = UINavigationController(rootViewController: serviceVC)
        let newsNav = UINavigationController(rootViewController: newsVC)
        let supportNav = UINavigationController(rootViewController: supportVC)

        tabbarController.viewControllers = [homeNav, carsNav, servicesNav, newsNav, supportNav]

        tabbarController.delegate = self

        return tabbarController
    }

    func moveToHome() {
        
        self.tabbar = self.createTabbarControler()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabbar
        self.window?.makeKeyAndVisible()
    }
    
    func moveToTermOfUse() {
        if let termOfUseVC = R.storyboard.main.termsOfUseViewController() {
            let nav = UINavigationController(rootViewController: termOfUseVC)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        FirebaseApp.configure()

        Api.default.setAccessToken(UserPrefsHelper.shared.getAccessToken(), userId: UserPrefsHelper.shared.getUserId())
        
        DropDown.startListeningToKeyboard()
        
        //  Custom time to show splash screen
        Thread.sleep(forTimeInterval: 0.5)
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
//          Check for the first time use app
        if UserPrefsHelper.shared.getAgreeTermOfUse() {
            self.moveToHome()
        }else{
            self.moveToTermOfUse()
        }
        GMSServices.provideAPIKey(Constants.googleAPIKey)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let nav = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController {
            nav.popToRootViewController(animated: false)
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}

