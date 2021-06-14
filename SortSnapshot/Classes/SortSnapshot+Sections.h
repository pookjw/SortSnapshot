//
//  SortSnapshot+Sections.h
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

#include <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TVOS
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSDiffableDataSourceSnapshot (SortSnapshot_Sections)
- (void)ssSortSectionsUsingComparator:(NSComparator NS_NOESCAPE)cmptr;
- (void)ssSortSectionsUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;
@end

NS_ASSUME_NONNULL_END
