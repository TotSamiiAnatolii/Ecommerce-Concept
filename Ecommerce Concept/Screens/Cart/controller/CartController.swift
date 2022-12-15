//
//  CartController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 06.12.2022.
//

import UIKit

final class CartController: UIViewController {
    
    fileprivate var cartView: CartView {
        guard let view = self.view as? CartView else { return CartView() }
        return view
    }
    
    private var model: ModelBasket? {
        didSet {
            DispatchQueue.main.async {
                guard let model = self.model else {
                    return
                }
                self.configureView(model: model)
            }
        }
    }
    
    private var modelsCell: [ModelCartCell] = [] {
        didSet {
            DispatchQueue.main.async {
                self.cartView.tableView.reloadData()
            }
        }
    }
    
    private let basketAPI = CartAPI()
    
    override func loadView() {
        super.loadView()
        self.view = CartView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        basketAPI.getDetails { result in
            switch result {
            case .success(let data):
                self.model = data
                self.modelsCell = self.mapCell(model: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        cartView.onAction = {[weak self] button in
            self?.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    private func mapCell(model: ModelBasket) -> [ModelCartCell] {
        model.basket.map { model in
            
            let productData = try? Data(contentsOf: URL(string: model.images)!)
            let photoProduct = UIImage(data: productData!)
            return ModelCartCell(
                count: 1,
                titleProduct: model.title,
                price: model.price,
                onAction: {[weak self] button in
                    self?.trashButtonAction(sender: button)
                },
                photo: photoProduct!)
        }
    }
    
    private func configureTableView() {
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
    }
    
    private func configureView(model: ModelBasket) {
        cartView.configure(with: ModelCartView(
            totalSum: model.total,
            deliveryResult: model.delivery))
    }
    
    private func totalCount() -> Int {
        var count: Int = 0
        modelsCell.forEach { product in
            let sum = product.totalSum
            count += sum
        }
        return count
    }
    
    private func trashButtonAction(sender: UIButton) {
        if cartView.tableView != nil {
            let point = cartView.tableView.convert(sender.center, from: sender.superview!)
            guard let indexPath = cartView.tableView.indexPathForRow(at: point) else {return}
            modelsCell.remove(at: indexPath.row)
            cartView.tableView.reloadData()
            self.model?.total = totalCount()
        }
    }
    
    private func changeQuantity(count: Int, sender: UIButton) {
        
        if cartView.tableView != nil {
            let point = cartView.tableView.convert(sender.center, from: sender.superview!)
            guard let indexPath = cartView.tableView.indexPathForRow(at: point) else {return}
            
            switch count {
            case _ where count == 0:
                self.model?.total = totalCount()
                modelsCell.remove(at: indexPath.row)
            case _ where count > 0:
                modelsCell[indexPath.row].count = count
                self.model?.total = totalCount()
            default:
                break
            }
        }
    }
}
extension CartController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifire, for: indexPath) as! CartCell
        
        if indexPath.row < modelsCell.count {
            cell.configure(with: modelsCell[indexPath.row])
            cell.addCount.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}
extension CartController: CustomAddCountDelegate {
    func featchCount(count: Int, sender: UIButton) {
        changeQuantity(count: count, sender: sender)
    }
}
