//
//  BrandController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit


protocol BrandDelegate: AnyObject {
    func titleBrand(title: String)
}

final class BrandController: UIViewController {

    fileprivate var brandView: BrandView {
        guard let view = self.view as? BrandView else { return BrandView()}
        return view
    }
    
    private var brands = [ModelBrandCell(nameBrand: "Iphone", isSelected: false),
                          ModelBrandCell(nameBrand: "Samsung", isSelected: true),
                          ModelBrandCell(nameBrand: "Motorola", isSelected: false),
                          ModelBrandCell(nameBrand: "Xiaomi", isSelected: false)]
    
    private var lastSelectedIndexPath: IndexPath = [0, 0]
    
    private var selectedBrand = ""
    
    weak var delegate: BrandDelegate?
    
    override func loadView() {
        super.loadView()
        self.view = BrandView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    private func configureView() {
        let radius: CGFloat = 30
        self.view.layer.cornerRadius = radius
        
        brandView.configure(with: BrandView.Model(
            onAction: {[weak self] type in
                self?.navBarItemAction(item: type)
        }))
    }
    private func configureTableView() {
        brandView.tableView.delegate = self
        brandView.tableView.dataSource = self
    }
    
    private func navBarItemAction(item: NavBarItem) {
        switch item {
        case .close:
            self.dismiss(animated: true)
        case .done:
            self.delegate?.titleBrand(title: selectedBrand)
            self.dismiss(animated: true)
        }
    }
}
extension BrandController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let brandCell = tableView.dequeueReusableCell(withIdentifier: BrandCell.identifire, for: indexPath) as? BrandCell else { return UITableViewCell()}
        
        if indexPath.row < brands.count {
            if self.brands[indexPath.row].isSelected {
                lastSelectedIndexPath = indexPath
            }
            brandCell.configure(with: brands[indexPath.row])
        }
    
        return brandCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) as? BrandCell else { return }
        
        let currencyIsSelected = brands[indexPath.row].isSelected
        
        guard currencyIsSelected == false else { return }
        
        brands[indexPath.row].isSelected = true
        
        cell.isSelected = true
        
        guard let cellSelected = tableView.cellForRow(at: lastSelectedIndexPath) as? BrandCell else { return }
        
        cellSelected.isSelected = false
        
        brands[lastSelectedIndexPath.row].isSelected = false
        
        lastSelectedIndexPath = indexPath
        
        selectedBrand = brands[indexPath.row].nameBrand
    }
}
