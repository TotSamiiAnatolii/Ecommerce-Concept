//
//  MainCoordinator.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

final class MainCoordinator {
   
    //MARK: Properties navigation
    
    private var mainNavigationController: UINavigationController
    
    private var filterNavgationController = UINavigationController()
        
    //MARK: Init
    init(navigationController: UINavigationController ) {
        
        self.mainNavigationController = navigationController
    }
    
    public func start() {
        showMainVC()
       
        setupApperance()
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .black
    }
    
    //MARK: View controllers
    private func showMainVC() {
        let mainVC = MainViewController()

        self.mainNavigationController.setViewControllers([mainVC], animated: true)
        
        mainVC.coordinatorTabBar = { [weak self] button in
            guard let self = self else { return }
            switch button {
            case .shop:
                self.showCartVC()
            case .favorite:
                self.showFavoriteVC()
            case .person:
                self.showPersonVC()
            case .filter:
                self.showFilterVC(transition: mainVC.transition, controller: mainVC)
            }
        }

        mainVC.coordinator = { [weak self]  in
            self?.showDetailVC()
        }
    }
    
    private func showCartVC() {
        let cartVC = CartController()
        self.mainNavigationController.pushViewController(cartVC, animated: true)

    }
    
    private func showDetailVC() {
        let detailVC = DetailsController()
        
        self.mainNavigationController.pushViewController(detailVC, animated: true)

    }
    
    private func showFilterVC(transition: PanelTransition, controller: UIViewController) {
        let filterVC = FilterController()
        
        filterVC.coordinator = { [weak self] type in
            switch type {
            case .brand:
                self?.showBrandFilter(transition: filterVC.transition, controller: filterVC)
            case .price:
                self?.showPriceFilter(transition: filterVC.transition, controller: filterVC)
            case .size:
                print("size")
            }
        }
    
        filterVC.transitioningDelegate = transition
        filterVC.modalPresentationStyle = .custom
        filterVC.delegate = controller as? FilterDelegate
        
        self.mainNavigationController.present(filterVC, animated: true)
        
    }
    
    private func showBrandFilter(transition: PanelTransition, controller: UIViewController) {
        let brandFilterVC = BrandController()
        brandFilterVC.transitioningDelegate = transition
        brandFilterVC.modalPresentationStyle = .custom
        brandFilterVC.delegate = controller as? BrandDelegate
        controller.present(brandFilterVC, animated: true)
    }
    
    private func showPriceFilter(transition: PanelTransition, controller: UIViewController) {
        let priceFilterVC = PriceFilterController()
        priceFilterVC.transitioningDelegate = transition
        priceFilterVC.modalPresentationStyle = .custom
        priceFilterVC.delegate = controller as? PriceDelegate
        controller.present(priceFilterVC, animated: true)
    }
    
    private func showFavoriteVC() {
    }
    
    private func showPersonVC() {
    }
    
    //MARK: Update interfeces
    private func updateInterfacesPhotoController() {
        DispatchQueue.main.async {
        }
    }
    
    private func updateInterfacesSearchPhotoController() {
        DispatchQueue.main.async {
            
        }
    }
    
    private func updateInterfacesProfileController() {
        DispatchQueue.main.async {

        }
    }
}

class ProductStore {
    
    private enum Keys {
        static let notificationKey = "updatedCart"
    }
    
    func subscribeForUpdates(object: Any?, handler: @escaping (ModelCart) -> Void) {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: "ProductStore.Update"),
            object: object,
            queue: .main) { notification in
                if let userInfo = notification.userInfo,
                   let updateCart = userInfo[Keys.notificationKey] as? ModelCart {
                    handler(updateCart)
                }
            }
    }
    
    func notifyAboutUpdate(product: ModelCart) {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "ProductStore.Update"),
            object: nil,
            userInfo: [Keys.notificationKey: product])
    }
}
