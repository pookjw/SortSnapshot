# SortSnapshot
[![Version](https://img.shields.io/cocoapods/v/SortSnapshot.svg?style=flat)](https://cocoapods.org/pods/SortSnapshot)
[![License](https://img.shields.io/cocoapods/l/SortSnapshot.svg?style=flat)](https://cocoapods.org/pods/SortSnapshot)
[![Platform](https://img.shields.io/cocoapods/p/SortSnapshot.svg?style=flat)](https://cocoapods.org/pods/SortSnapshot)

SortSnapshot extends sorting method to [NSDiffableDataSourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot) and [NSDiffableDataSourceSnapshotReference](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshotreference).

![](images/demo.gif)

## Requirements

- iOS 13.0 or later
- macOS 10.15.1 or later
- tvOS 13.0 or later

## Installation

SortSnapshot is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SortSnapshot'
```

## Usage (Swift)

```swift
var snapshot: NSDiffableDataSourceSnapshot<Int, Int> = dataSource.snapshot()

// Ascending Sort
snapshot.ssSortSections()
snapshot.ssSortItems(snapshot.sectionIdentifiers)

// Descending Sort
snapshot.ssSortSections(by: >)
snapshot.ssSortItems(snapshot.sectionIdentifiers, by: >)

// Random Sort
snapshot.ssSortSections(by: { _, _ in .random() })
snapshot.ssSortItems(snapshot.sectionIdentifiers, by: { _, _ in .random() })

// ... apply to Data Source
dataSource.apply(snapshot)
```

## Usage (Objective-C)

### Using NSComparator

```objective-c
NSDiffableDataSourceSnapshot *snapshot = self.dataSource.snapshot;

// Ascending Sort
NSComparator ascendingComparator = ^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return [obj1 compare:obj2];
};
    
[snapshot ssSortSectionsUsingComparator:ascendingComparator];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:ascendingComparator];

// Descending Sort
NSComparator descendingComparator = ^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return [obj2 compare:obj1];
};
    
[snapshot ssSortSectionsUsingComparator:descendingComparator];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:descendingComparator];

// Random Sort
NSComparator randomComparator = ^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return arc4random_uniform(3) - 1;
};
    
[snapshot ssSortSectionsUsingComparator:randomComparator];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingComparator:randomComparator];

// ... apply to Data Source
[self.dataSource applySnapshot:snapshot animatingDifferences:YES];
```

### Using NSSortDescriptor

```objective-c
NSDiffableDataSourceSnapshot *snapshot = self.dataSource.snapshot;

// Ascending Sort
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return [obj1 compare:obj2];
}];
    
[snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];

// Descending Sort
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return [obj2 compare:obj1];
}];
    
[snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];

// Random Sort
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                                   ascending:NO
                                                                  comparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
    return arc4random_uniform(3) - 1;
}];

[snapshot ssSortSectionsUsingDescriptors:@[sortDescriptor]];
[snapshot ssSortItemsWithIdentifiers:snapshot.sectionIdentifiers usingDescriptors:@[sortDescriptor]];

// ... apply to Data Source
[self.dataSource applySnapshot:snapshot animatingDifferences:YES];
```

## Author

Jinwoo Kim, kidjinwoo@me.com

## License

SortSnapshot is available under the MIT license. See the LICENSE file for more info.
