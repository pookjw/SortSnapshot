//
//  SortSnapshot+Items.m
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import "SortSnapshot+Items.h"

@implementation NSDiffableDataSourceSnapshot (SortSanpshot_Items)

- (void)ssSortItemsWithIdentifiers:(NSArray *)sectionIdentifiers usingComparator:(NSComparator NS_NOESCAPE)cmptr {
    for (id sectionIdentifier in sectionIdentifiers) {
        NSMutableArray *tmpItemIdentifiers = [[self itemIdentifiersInSectionWithIdentifier:sectionIdentifier] mutableCopy];
        
        if (tmpItemIdentifiers.count < 2) return;
        
        for (NSUInteger a = 0; a < tmpItemIdentifiers.count; a++) {
            for (NSUInteger b = a + 1; b < tmpItemIdentifiers.count; b++) {
                id aItemIdentifier = tmpItemIdentifiers[a];
                id bItemIdentifier = tmpItemIdentifiers[b];
                NSComparisonResult result = cmptr(aItemIdentifier, bItemIdentifier);
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
                    id beforeBItemIdentifier = tmpItemIdentifiers[b - 1];
                    
                    [self moveItemWithIdentifier:bItemIdentifier beforeItemWithIdentifier:aItemIdentifier];
                    
                    if (![beforeBItemIdentifier isEqual:aItemIdentifier]) {
                        [self moveItemWithIdentifier:aItemIdentifier afterItemWithIdentifier:beforeBItemIdentifier];
                    }
                    
                    [tmpItemIdentifiers exchangeObjectAtIndex:a withObjectAtIndex:b];
                }
            }
        }
    }
}

- (void)ssSortItemsWithIdentifiers:(NSArray *)sectionIdentifiers usingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors {
    for (NSSortDescriptor *sortDescriptor in sortDescriptors) {
        NSComparator cmptr = ^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [sortDescriptor compareObject:obj1 toObject:obj2];
            return result;
        };
        
        [self ssSortItemsWithIdentifiers:sectionIdentifiers usingComparator:cmptr];
    }
}

@end
