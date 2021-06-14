//
//  SortSnapshot+Sections.m
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import "SortSnapshot+Sections.h"

@implementation NSDiffableDataSourceSnapshot (SortSnapshot_Sections)

- (void)ssSortSectionsUsingComparator:(NSComparator NS_NOESCAPE)cmptr {
    NSMutableArray *tmpSectionIdentifiers = [self.sectionIdentifiers mutableCopy];
    
    if (tmpSectionIdentifiers.count < 2) return;
    
    for (NSUInteger a = 0; a < tmpSectionIdentifiers.count; a++) {
        for (NSUInteger b = a + 1; b < tmpSectionIdentifiers.count; b++) {
            id aSectionIdentifier = tmpSectionIdentifiers[a];
            id bSectionIdentifier = tmpSectionIdentifiers[b];
            NSComparisonResult result = cmptr(aSectionIdentifier, bSectionIdentifier);
            BOOL shouldSwap;
            
            switch (result) {
                case NSOrderedAscending:
                    shouldSwap = NO;
                    break;
                case NSOrderedSame:
                    shouldSwap = NO;
                    break;
                case NSOrderedDescending:
                    shouldSwap = YES;
                    break;
                default:
                    shouldSwap = NO;
                    break;
            }
            
            if (shouldSwap) {
                id beforeBSectionIdentifier = tmpSectionIdentifiers[b - 1];
                
                [self moveSectionWithIdentifier:bSectionIdentifier beforeSectionWithIdentifier:aSectionIdentifier];
                
                if (![beforeBSectionIdentifier isEqual:aSectionIdentifier]) {
                    [self moveSectionWithIdentifier:aSectionIdentifier afterSectionWithIdentifier:beforeBSectionIdentifier];
                }
                
                [tmpSectionIdentifiers exchangeObjectAtIndex:a withObjectAtIndex:b];
            }
        }
    }
}

- (void)ssSortSectionsUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors {
    for (NSSortDescriptor *sortDescriptor in sortDescriptors) {
        NSComparator cmptr = ^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [sortDescriptor compareObject:obj1 toObject:obj2];
            return result * (sortDescriptor.ascending ? 1L : -1L);
        };
        
        [self ssSortSectionsUsingComparator:cmptr];
    }
}

@end
