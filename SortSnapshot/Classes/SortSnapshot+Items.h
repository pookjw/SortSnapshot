//
//  SortSnapshot+Items.h
//  SortSnapshotDemo
//
//  Created by Jinwoo Kim on 6/14/21.
//

#include <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSDiffableDataSourceSnapshot (SortSanpshot_Items)
- (void)ssSortItemsWithIdentifiers:(NSArray *)sectionIdentifiers usingComparator:(NSComparator NS_NOESCAPE)cmptr;
- (void)ssSortItemsWithIdentifiers:(NSArray *)sectionIdentifiers usingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;
@end

NS_ASSUME_NONNULL_END
