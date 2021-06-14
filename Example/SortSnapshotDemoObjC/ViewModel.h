//
//  ViewModel.h
//  SortSnapshotDemoObjC
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import <UIKit/UIKit.h>

typedef UICollectionViewDiffableDataSource<NSNumber *, NSNumber *> DataSource;

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject
@property (nonatomic, readonly) DataSource *dataSource;
- (instancetype)initWithDataSource:(DataSource *)dataSource;
- (NSNumber * _Nullable )getSectionItemFromIndexPath:(NSIndexPath *)indexPath;
- (void)configureInitialData;
- (void)sortByRandom;
- (void)sortByDescending;
- (void)sortByAscending;
@end

NS_ASSUME_NONNULL_END
