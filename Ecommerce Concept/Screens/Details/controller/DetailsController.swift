//
//  DetailsController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 05.12.2022.
//

import UIKit

final class DetailsController: UIViewController {
    
    fileprivate var detailsView: DetailsView {
        guard let view = self.view as? DetailsView else { return DetailsView() }
        return view
    }
    
    public var coordinator: ((ModelCart) -> Void)?
    
    public var coordinatorNav: (() -> Void)?
    
    private var model: ModelDetail? {
        didSet {
            detailsCell = mapModelCell(model: model!.images)
            DispatchQueue.main.async {
                self.detailsView.collectionView.reloadData()
            }
        }
    }
    
    private var modelView: ModelDetailsView? {
        didSet {
            DispatchQueue.main.async {
                self.configureView(model: self.modelView)
            }
        }
    }
    
    private var detailsCell: [ModelDetailsCell] = []
    
    private let detailsAPI = DetailsAPI()
    
    override func loadView() {
        super.loadView()
        self.view = DetailsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.segmentControl.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        detailsView.collectionView.delegate = self
        detailsView.collectionView.dataSource = self
        
        detailsAPI.getDetails { result in
            switch result {
            case .success(let data):
                self.modelView = self.mapViewModel(model: data)
                self.model = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func buttonAction(sender: DetailsButton) {
        switch sender {
        case .back:
            self.navigationController?.popToRootViewController(animated: true)
        case .cart:
            print("cart")
        case .addCart:
            print("ADDCart")
        }
    }
    
    private func mapModelCell(model: [String]) -> [ModelDetailsCell] {
        return model.map { photo -> ModelDetailsCell in
            let profileData = try? Data(contentsOf: URL(string: photo)!)
            
            let postImage = UIImage(data: profileData!)
            
            return ModelDetailsCell(photoProduct: postImage!)
        }
    }

    private func mapViewModel(model: ModelDetail) -> ModelDetailsView {
        return ModelDetailsView(
            onAction: { [weak self] button in
                self?.buttonAction(sender: button)
            },
            nameProduct: model.title,
            camera: model.camera,
            cpu: model.cpu,
            ssd: model.ssd,
            sd: model.sd,
            color: model.color,
            capacity: model.capacity)
    }
    
    private func configureView(model: ModelDetailsView?) {
        guard let view = model else { return }
        detailsView.configure(with: view)
    }
}
extension DetailsController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailsCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellDetails = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifire, for: indexPath) as! DetailsCell
        cellDetails.configure(with: detailsCell[indexPath.row])
        
        return cellDetails
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension DetailsController: DetailsSegmentedControlDelegate {
    func onAction(index: Int) {
        
    }
}
