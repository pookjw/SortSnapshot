//
//  ViewController.swift
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

import UIKit

class ViewController: UIViewController {
    private weak var collectionView: UICollectionView!
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        configureCollectionView()
        configureBarButtonItems()
        configureViewModel()
    }
    
    private func setAttributes() {
        title = "SortSnapshotDemoSwift"
    }
    
    private func configureCollectionView() {
        let collectionViewLayout: UICollectionViewCompositionalLayout = .init(sectionProvider: makeSectionProvider())
        let collectionView: UICollectionView = .init(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        self.collectionView = collectionView
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionViewListCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.delegate = self
    }
    
    private func makeSectionProvider() -> UICollectionViewCompositionalLayoutSectionProvider {
        return { (section: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var configuration: UICollectionLayoutListConfiguration = .init(appearance: .insetGrouped)
            
            configuration.headerMode = .supplementary
            
            return .list(using: configuration, layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func configureBarButtonItems() {
        let sortByRandomButton: UIBarButtonItem = .init(title: nil,
                                                        image: UIImage(systemName: "shuffle"),
                                                        primaryAction: .init { [weak self] _ in self?.viewModel.sortByRandom() },
                                                        menu: nil)
        
        let sortByDecendingButton: UIBarButtonItem = .init(title: nil,
                                                           image: UIImage(systemName: "arrow.up"),
                                                           primaryAction: .init { [weak self] _ in self?.viewModel.sortByDecending() },
                                                           menu: nil)
        
        let sortByAscendingButton: UIBarButtonItem = .init(title: nil,
                                                           image: UIImage(systemName: "arrow.down"),
                                                           primaryAction: .init { [weak self] _ in self?.viewModel.sortByAscending() },
                                                           menu: nil)
        
        navigationItem.leftBarButtonItems = [sortByRandomButton]
        navigationItem.rightBarButtonItems = [sortByDecendingButton, sortByAscendingButton]
    }
    
    private func configureViewModel() {
        let viewModel: ViewModel = .init(dataSource: makeDataSource())
        self.viewModel = viewModel
        viewModel.configureInitialData()
    }
    
    private func makeDataSource() -> ViewModel.DataSource {
        let dataSource: ViewModel.DataSource = .init(collectionView: collectionView, cellProvider: makeCellProvider())
        
        dataSource.supplementaryViewProvider = makeSupplementaryViewProvider()
        
        return dataSource
    }
    
    private func makeCellProvider() -> ViewModel.DataSource.CellProvider {
        return { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell: UICollectionViewListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewListCell else {
                return nil
            }
            
            var configuration: UIListContentConfiguration = cell.defaultContentConfiguration()
            configuration.text = String(item)
            cell.contentConfiguration = configuration
            
            return cell
        }
    }
    
    private func makeSupplementaryViewProvider() -> ViewModel.DataSource.SupplementaryViewProvider {
        return { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            guard let section: Int = self?.viewModel.getSectionItem(from: indexPath) else {
                return nil
            }
            
            guard let headerView: UICollectionViewListCell = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "headerView", for: indexPath) as? UICollectionViewListCell else {
                return nil
            }
            
            var configuration: UIListContentConfiguration = headerView.defaultContentConfiguration()
            configuration.text = String(section)
            headerView.contentConfiguration = configuration
            
            return headerView
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
