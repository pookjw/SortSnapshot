//
//  SortSnapshot+Sections.swift
//  SortSnapshot
//
//  Created by Jinwoo Kim on 6/13/21.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSDiffableDataSourceSnapshot {
    mutating func ssSortSections(by areInIncreasingOrder: (SectionIdentifierType, SectionIdentifierType) -> Bool) {
        var tmpSectionIdentifiers: [SectionIdentifierType] = sectionIdentifiers
        
        guard tmpSectionIdentifiers.count >= 2 else {
            return
        }
        
        for a in 0 ..< tmpSectionIdentifiers.count {
            for b in (a + 1) ..< tmpSectionIdentifiers.count {
                let aSectionIdentifier: SectionIdentifierType = tmpSectionIdentifiers[a]
                let bSectionIdentifier: SectionIdentifierType = tmpSectionIdentifiers[b]
                let shouldSwap: Bool = !(areInIncreasingOrder(aSectionIdentifier, bSectionIdentifier))
                
                if shouldSwap {
                    let beforeBSectionIdentifier: SectionIdentifierType = tmpSectionIdentifiers[b - 1]
                    
                    moveSection(bSectionIdentifier, beforeSection: aSectionIdentifier)
                    
                    if beforeBSectionIdentifier != aSectionIdentifier {
                        moveSection(aSectionIdentifier, afterSection: beforeBSectionIdentifier)
                    }
                    
                    tmpSectionIdentifiers.swapAt(a, b)
                }
            }
        }
    }
}

extension NSDiffableDataSourceSnapshot where SectionIdentifierType: Comparable {
    mutating func ssSortSections() {
        ssSortSections(by: <)
    }
}

#if IS_XCODE_13_OR_LATER
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
extension NSDiffableDataSourceSnapshot {
    mutating func ssSortSections<T: SortComparator>(using comparator: T) where T.Compared == SectionIdentifierType {
        ssSortSections { first, second in
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
