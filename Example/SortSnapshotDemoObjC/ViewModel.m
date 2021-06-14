//
//  ViewModel.m
//  SortSnapshotDemoObjC
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import "ViewModel.h"
@import SortSnapshot;

typedef NSDiffableDataSourceSnapshot Snapshot;

@interface ViewModel ()
@property (nonatomic, readonly) Snapshot *snapshot;
@end

@implementation ViewModel

- (instancetype)initWithDataSource:(DataSource *)dataSource {
    self = [self init];
    
    if (self) {
        self->_dataSource = dataSource;
    }
    
    return self;
}

- (Snapshot *)snapshot {
    return self.dataSource.snapshot;
}

- (NSNumber * _Nullable )getSectionItemFromIndexPath:(NSIndexPath *)indexPath {
#if IS_XCODE_13_OR_LATER
    if (@available(iOS 15.0, *)) {
        return [self.dataSource sectionIdentifierForIndex:indexPath.section];
    } else {
        NSArray<NSNumber *> *sectionIdentifiers = [self.snapshot sectionIdentifiers];
        
        if (sectionIdentifiers.count <= indexPath.section) return nil;
        
        return sectionIdentifiers[indexPath.section];
    }
#else
    NSArray<NSNumber *> *sectionIdentifiers = [self.snapshot sectionIdentifiers];
    
    if (sectionIdentifiers.count <= indexPath.section) return nil;
    
    return sectionIdentifiers[indexPath.section];
#endif
}

- (void)configureInitialData {
    Snapshot *snapshot = self.snapshot;
    
    [snapshot appendSectionsWithIdentifiers:@[@0, @1, @2]];
    
    [snapshot appendItemsWithIdentifiers:@[@0, @1, @2, @3, @4]
               intoSectionWithIdentifier:@0];
    
    [snapshot appendItemsWithIdentifiers:@[@5, @6, @7, @8]
               intoSectionWithIdentifier:@1];
    
    [snapshot appendItemsWithIdentifiers:@[@9, @10, @11]
               intoSectionWithIdentifier:@2];
    
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

- (void)sortByRandom {
    Snapshot *snapshot = self.snapshot;
    
//    [snapshot ssSortSectionsUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return arc4random_uniform(3) - 1;
//    }];
//    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return arc4random_uniform(3) - 1;
//    }];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return arc4random_uniform(3) - 1;
    }];
    
    [snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];
    
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

- (void)sortByDecending {
    Snapshot *snapshot = self.snapshot;
    
//    [snapshot ssSortSectionsUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return [obj2 compare:obj1];
//    }];
//    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return [obj2 compare:obj1];
//    }];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj2 compare:obj1];
    }];
    
    [snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];
    
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

- (void)sortByAscending {
    Snapshot *snapshot = self.snapshot;
    
//    [snapshot ssSortSectionsUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return [obj1 compare:obj2];
//    }];
//    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//        return [obj1 compare:obj2];
//    }];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    
    [snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
    [snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];
    
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

@end
