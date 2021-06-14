//
//  ViewModel.swift
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

import UIKit
import SortSnapshot

class ViewModel {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private let dataSource: DataSource
    private var snapshot: Snapshot { dataSource.snapshot() }
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getSectionItem(from indexPath: IndexPath) -> Int? {
        #if IS_XCODE_13_OR_LATER
        return dataSource.sectionIdentifier(for: indexPath.section)
        #else
        let sectionIdentifiers: [Int] = snapshot.sectionIdentifiers
        
        guard sectionIdentifiers.count > indexPath.section else {
            return nil
        }
        
        return sectionIdentifiers[indexPath.section]
        #endif
    }
    
    func configureInitialData() {
        var snapshot: Snapshot = snapshot
        
        snapshot.appendSections([0, 1, 2])
    
        snapshot.appendItems([
            0,
            1,
            2,
            3,
            4
        ], toSection: 0)
        
        snapshot.appendItems([
            5,
            6,
            7,
            8
        ], toSection: 1)
        
        snapshot.appendItems([
            9,
            10,
            11
        ], toSection: 2)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func sortByRandom() {
        var snapshot: Snapshot = snapshot
        
        snapshot.ssSortSections(by: { _, _ in .random() })
        snapshot.ssSortItems(snapshot.sectionIdentifiers, by: { _, _ in .random() })
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func sortByDescending() {
        var snapshot: Snapshot = snapshot
        
        snapshot.ssSortSections(by: >)
        snapshot.ssSortItems(snapshot.sectionIdentifiers, by: >)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func sortByAscending() {
        var snapshot: Snapshot = snapshot
        
        snapshot.ssSortSections()
        snapshot.ssSortItems(snapshot.sectionIdentifiers)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
