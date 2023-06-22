//
//  ViewController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

enum SectionType: Int {
    case hot
    case best
    
    func nameCollection() -> String {
        switch self {
        case .hot:
            return "Hot sales"
        case .best:
            return "Best Seller"
        }
    }
}

enum mainButton {
    case filter
    case shop
    case favorite
    case person
}

final class MainViewController: UIViewController {
    
    fileprivate var mainView: MainView {
        guard let view = self.view as? MainView else { return MainView() }
        return view
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, AnyHashable>?
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    public var coordinator: (() -> Void)?
    
    public var coordinatorTabBar: ((mainButton) -> Void)?
    
    private let myCategory = Category()
    
    public let transition = PanelTransition()
    
    private var categoryModel: [CategoryModel] = [] {
        didSet {
            mainView.selectCategoryCollection.reloadData()
        }
    }
    
    private var cartArray: [ModelCart] = []
    
    private var homeStore: [HomeStore] = [] {
        didSet {
            modelHotCell = mapHotCell(model: homeStore)
        }
    }
    
    private var bestSeller: [BestSeller] = [] {
        didSet {
            modelBestCell = mapBestCell(model: bestSeller)
        }
    }
    
    private var filteredBestSeller = [ModelBestCell]()
    
    private var lastIndexPath: IndexPath = []
    
    private var modelHotCell: [ModelHotCell] = []
    
    private var modelBestCell: [ModelBestCell] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData(array: self.modelBestCell)
            }
        }
    }
    
    private let photoAPI = MainAPI()
    
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategory()
        
        photoAPI.getRequestProduct { result in
            switch result {
            case .success(let data):
                self.homeStore = data.homeStore
                self.bestSeller = data.bestSeller
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        configureNavBar()
        setSelectCategoryCollection()
        configureCollectionView()
        configureView()
        createDataSource()
    }
    
    private func configureView() {
        mainView.configure(with: ModelMainView(
            onAction: { [weak self] button in
                self?.buttonAction(sender: button)
            }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionView() {
        mainView.collectionView.collectionViewLayout = createCompositionalLayout()
        mainView.collectionView.register(HotCell.self, forCellWithReuseIdentifier: HotCell.identifire)
        mainView.collectionView.register(BestCell.self, forCellWithReuseIdentifier: BestCell.identifire)
        mainView.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifire)
        mainView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
    }
    
    private func configureSearchController() {
        mainView.searchController.searchBar.delegate = self
        mainView.searchController.searchResultsUpdater = self

        definesPresentationContext = true
    }
    
    private func mapBestCell(model: [BestSeller]) -> [ModelBestCell] {
        model.map { model in
            let productData = try? Data(contentsOf: URL(string: model.picture)!)
            
            let photoProduct = UIImage(data: productData ?? Data())
            
            return ModelBestCell(
                productPhoto: photoProduct ?? UIImage(),
                productTitle: model.title,
                priceDiscount: model.discountPrice,
                priceNoDiscount: model.priceWithoutDiscount)
        }
    }
    
    private func mapHotCell(model: [HomeStore]) -> [ModelHotCell] {
        model.map { model in
            let profileData = try? Data(contentsOf: URL(string: model.picture)!)
            
            let postImage = UIImage(data: profileData!)
            
            return ModelHotCell(
                productPhoto: postImage!,
                new: model.isNew ?? true,
                title: model.title,
                detail: model.subtitle)
        }
    }
    
    private func setCategory() {
        categoryModel = myCategory.getCategory()
    }
    
    private func buttonAction(sender: mainButton) {
        switch sender {
        case .shop:
            coordinatorTabBar?(.shop)
        case .favorite:
            coordinatorTabBar?(.favorite)
        case .person:
            coordinatorTabBar?(.person)
        case .filter:
            coordinatorTabBar?(.filter)
        }
    }
    
    private func setSelectCategoryCollection() {
        mainView.selectCategoryCollection.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifire)
        
        mainView.selectCategoryCollection.delegate = self
        mainView.selectCategoryCollection.dataSource = self
        mainView.collectionView.delegate = self
    }
 
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = SectionType(rawValue: indexPath.section)
            
            switch section {
            case .hot:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotCell.identifire, for: indexPath) as? HotCell
                cell?.configure(with: self.modelHotCell[indexPath.row])
                return cell
                
            case .best:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestCell.identifire, for: indexPath) as? BestCell
                cell?.configure(with: self.modelBestCell[indexPath.row])
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifire,
                for: indexPath) as? HeaderView
            
            guard let section = SectionType(rawValue: indexPath.section) else { return UICollectionReusableView()}
            
            view?.configure(with: ModelHeaderView(
                title: (section.nameCollection())))
            return view
        }
    }
    
    private func reloadData(array: [ModelBestCell]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, AnyHashable>()
        snapshot.appendSections([.hot, .best])
        snapshot.appendItems(modelHotCell, toSection: .hot)
        snapshot.appendItems(array, toSection: .best)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = SectionType(rawValue: sectionIndex)
            
            switch section {
            case .hot:
                return self.myCompositionalLayout.setHotFlowLayout()
            case .best:
                return self.myCompositionalLayout.setBestFlowLayout()
            case .none:
                return nil
            }
        }
        return layout
    }
    
    func filterFoBrand( brand: String) {
        filteredBestSeller = filteredNameProduct(name: brand)
        reloadData(array: filteredBestSeller)
    }
    
    func filterFoPrices(from: Int, to: Int) {
        filteredBestSeller = modelBestCell.filter{(from...to).contains($0.priceNoDiscount)}
        reloadData(array: filteredBestSeller)
    }
    
    func filteredNameProduct(name: String?) -> [ModelBestCell] {
        guard let nameProduct = name, !nameProduct.isEmpty else { return modelBestCell }
        return modelBestCell.filter { product in
            let rezult = product.productTitle.lowercased().contains(nameProduct.lowercased())
            return rezult
        }
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
        
        let model = categoryModel[indexPath.row]
        
        if model.isSelected {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            lastIndexPath = indexPath
        }
        
        if indexPath.row < categoryModel.count {
            categoryCell.configure(with: model)
        }
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 81, height: 93)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if mainView.collectionView == collectionView {
            coordinator?()
        }
        
        if mainView.selectCategoryCollection == collectionView {
            if indexPath != lastIndexPath {
                categoryModel[indexPath.row].isSelected = true
                categoryModel[lastIndexPath.row].isSelected = false
                lastIndexPath = indexPath
            }
        }
    }
}
extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension MainViewController: FilterDelegate {
    func filterBrand(brand: String) {
        filterFoBrand(brand: brand)
    }
    
    func filterPrice(from: Int, to: Int) {
        if from > 0 {
            self.filterFoPrices(from: from, to: to)
        }
    }
}
