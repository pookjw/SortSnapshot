//
//  ViewController.m
//  SortSnapshotDemoObjC
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController () <UICollectionViewDelegate>
@property (weak) UICollectionView *collectionView;
@property ViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributes];
    [self configureCollectionView];
    [self configureBarButtonItems];
    [self configureViewModel];
}

- (void)setAttributes {
    self.title = @"SortSnapshotDemoObjC";
}

- (void)configureCollectionView {
    UICollectionViewCompositionalLayout *collectionViewLayout = [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:[self makeSectionProvider]];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
    self.collectionView = collectionView;
    
    [self.view addSubview:collectionView];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    
    [collectionView registerClass:[UICollectionViewListCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerClass:[UICollectionViewListCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    collectionView.delegate = self;
}

- (UICollectionViewCompositionalLayoutSectionProvider)makeSectionProvider {
    return ^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> _Nonnull layoutEnvironment){
        UICollectionLayoutListConfiguration *configuration = [[UICollectionLayoutListConfiguration alloc] initWithAppearance:UICollectionLayoutListAppearanceInsetGrouped];
        
        configuration.headerMode = UICollectionLayoutListHeaderModeSupplementary;
        
        return [NSCollectionLayoutSection sectionWithListConfiguration:configuration layoutEnvironment:layoutEnvironment];
    };
}

- (void)configureBarButtonItems {
    __weak typeof(self) weakSelf = self;
    
    UIBarButtonItem *sortByRandomButton = [[UIBarButtonItem alloc] initWithPrimaryAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [weakSelf.viewModel sortByRandom];
    }]];
    
    UIBarButtonItem *sortByDescendingButton = [[UIBarButtonItem alloc] initWithPrimaryAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [weakSelf.viewModel sortByDescending];
    }]];
    
    UIBarButtonItem *sortByAscendingButton = [[UIBarButtonItem alloc] initWithPrimaryAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [weakSelf.viewModel sortByAscending];
    }]];
    
    sortByRandomButton.image = [UIImage systemImageNamed:@"shuffle"];
    sortByDescendingButton.image = [UIImage systemImageNamed:@"arrow.up"];
    sortByAscendingButton.image = [UIImage systemImageNamed:@"arrow.down"];
    
    self.navigationItem.leftBarButtonItems = @[sortByRandomButton];
    self.navigationItem.rightBarButtonItems = @[sortByDescendingButton, sortByAscendingButton];
}

- (void)configureViewModel {
    ViewModel *viewModel = [[ViewModel alloc] initWithDataSource:[self makeDataSource]];
    self.viewModel = viewModel;
    [viewModel configureInitialData];
}

- (DataSource *)makeDataSource {
    DataSource *dataSource = [[DataSource alloc] initWithCollectionView:self.collectionView
                                                           cellProvider:[self makeCellProvider]];
    
    dataSource.supplementaryViewProvider = [self makeSupplementaryViewProvider];
    
    return dataSource;
}

- (UICollectionViewDiffableDataSourceCellProvider)makeCellProvider {
    return ^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, NSNumber *item) {
        UICollectionViewListCell *cell = (UICollectionViewListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        UIListContentConfiguration *configuration = cell.defaultContentConfiguration;
        configuration.text = [NSString stringWithFormat:@"%lu", item.integerValue];
        cell.contentConfiguration = configuration;
        
        return cell;
    };
}

- (UICollectionViewDiffableDataSourceSupplementaryViewProvider)makeSupplementaryViewProvider {
    __weak typeof(self) weakSelf = self;
    return ^UICollectionReusableView * _Nullable(UICollectionView * _Nonnull collectionView, NSString * _Nonnull elementKind, NSIndexPath * _Nonnull indexPath) {
        NSNumber * _Nullable section = [weakSelf.viewModel getSectionItemFromIndexPath:indexPath];
        
        if (section == nil) return nil;
        
        UICollectionViewListCell *headerView = (UICollectionViewListCell *)[collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        UIListContentConfiguration *configuration = headerView.defaultContentConfiguration;
        configuration.text = [NSString stringWithFormat:@"%lu", section.integerValue];
        headerView.contentConfiguration = configuration;
        
        return headerView;
    };
}

#pragma mark UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
