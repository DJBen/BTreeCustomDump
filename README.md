# BTreeCustomDump

A Swift package that provides CustomDump integration for BTree data structures.

## Overview

This package extends the [BTree](https://github.com/attaswift/BTree) library to work seamlessly with [swift-custom-dump](https://github.com/pointfreeco/swift-custom-dump) for better debugging and testing experiences.

If you are using [BTree](https://github.com/attaswift/BTree) and [swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture), integrating this package allows your BTree-based state to appear as clean, readable dictionaries in debug output and test diffs. This makes it much easier to inspect, compare, and reason about state changes, especially when using tools like `assertNoDifference` or snapshot testing, leading to more maintainable and understandable tests.

## Installation

Add this package as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/attaswift/BTree.git", from: "4.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", from: "1.3.3"),
    .package(url: "https://github.com/DJBen/BTreeCustomDump.git", from: "1.0.0")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "BTree",
        "BTreeCustomDump",
        .product(name: "CustomDump", package: "swift-custom-dump")
    ]
)
```

## Features

- **CustomDumpReflectable** conformance for `BTree<Key, Value>` - displays as clean dictionary format
- **CustomDumpReflectable** conformance for `Map<Key, Value>` - displays as clean dictionary format  
- **CustomDumpReflectable** conformance for `List<Element>` - displays as indexed array
- **Unit Tests** - comprehensive test suite ensuring proper functionality

## Usage

Simply import both `BTree` and `BTreeCustomDump` in your code:

```swift
import BTree
import BTreeCustomDump
import CustomDump

var tree: BTree<String, Int> = BTree()
tree.insert(("apple", 5))
tree.insert(("banana", 3))
tree.insert(("cherry", 8))

customDump(tree)
```

This will output a clean, readable representation:

```
[
  apple: 5,
  banana: 3,
  cherry: 8
]
```

Compare this to the standard dump output which is much more verbose:

```
▿ BTree.BTree<Swift.String, Swift.Int>
  ▿ root: BTree.BTreeNode<Swift.String, Swift.Int> #0
    ▿ elements: 3 elements
      ▿ (2 elements)
        - .0: "apple"
        - .1: 5
      ▿ (2 elements)
        - .0: "banana"
        - .1: 3
      ▿ (2 elements)
        - .0: "cherry"
        - .1: 8
    - children: 0 elements
    - count: 3
    - _order: 682
    - _depth: 0
```

## Benefits

- **Clean debugging output** for data stored in BTrees
- **Improved test failure messages** when using `expectNoDifference`
- **Readable diffs** when comparing BTree-based state changes
- **Chronological data visualization** - BTrees maintain sorted order for time-based data
- **Reduced noise** in debug output and test logs

## Testing

Run the test suite to verify functionality:

```bash
swift test
```

The test suite includes:
- Basic BTree, Map, and List formatting tests
- Nested structure handling tests
- Empty collection tests
- Order preservation tests
- Comparison with standard dump output

## Requirements

- iOS 18.0+ / macOS 10.15+
- Swift 6.1+

## License

This package follows the same license as the parent project.
