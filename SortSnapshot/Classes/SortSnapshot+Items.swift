//
//  SortSnapshot+Items.swift
//  SortSnapshot
//
//  Created by Jinwoo Kim on 6/14/21.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSDiffableDataSourceSnapshot {
    public mutating func ssSortItems(_ identifiers: [SectionIdentifierType], by areInIncreasingOrder: (ItemIdentifierType, ItemIdentifierType) -> Bool) {
        for identifier in identifiers {
            var tmpItemIdentifiers: [ItemIdentifierType] = itemIdentifiers(inSection: identifier)
            
            guard tmpItemIdentifiers.count >= 2 else {
                continue
            }
            
            for a in 0 ..< tmpItemIdentifiers.count {
                for b in (a + 1) ..< tmpItemIdentifiers.count {
                    let aItemIdentifier: ItemIdentifierType = tmpItemIdentifiers[a]
                    let bItemIdentifier: ItemIdentifierType = tmpItemIdentifiers[b]
                    let shouldSwap: Bool = !(areInIncreasingOrder(aItemIdentifier, bItemIdentifier))
                    
                    if shouldSwap {
                        let beforeBItemIdentifier: ItemIdentifierType = tmpItemIdentifiers[b - 1]
                        
                        moveItem(bItemIdentifier, beforeItem: aItemIdentifier)
                        
                        if beforeBItemIdentifier != aItemIdentifier {
                            moveItem(aItemIdentifier, afterItem: beforeBItemIdentifier)
                        }
                        
                        tmpItemIdentifiers.swapAt(a, b)
                    }
                }
            }
        }
    }
}

extension NSDiffableDataSourceSnapshot where ItemIdentifierType: Comparable {
    public mutating func ssSortItems(_ identifiers: [SectionIdentifierType]) {
        ssSortItems(identifiers, by: <)
    }
}

#if IS_XCODE_13_OR_LATER
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
extension NSDiffableDataSourceSnapshot {
    public mutating func ssSortItems<T: SortComparator>(_ identifiers: [SectionIdentifierType], using comparator: T) where T.Compared == ItemIdentifierType {
        ssSortItems(identifiers) { first, second in
            let order: SortOrder = comparator.order
            let result: ComparisonResult = comparator.compare(first, second)

            switch (order, result) {
            case (.forward, .orderedAscending):
                return true
            case (.forward, .orderedDescending):
                return false
            case (.forward, .orderedSame):
                return false
            case (.reverse, .orderedAscending):
                return false
            case (.reverse, .orderedSame):
                return true
            case (.reverse, .orderedDescending):
                return false
            }
        }
    }
}
#endif
