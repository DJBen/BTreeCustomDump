import XCTest
import BTree
import CustomDump
@testable import BTreeCustomDump

final class BTreeCustomDumpTests: XCTestCase {
    
    func testBTreeCustomDumpOutput() {
        // Given
        var tree: BTree<String, Int> = BTree()
        tree.insert(("apple", 5))
        tree.insert(("banana", 3))
        tree.insert(("cherry", 8))
        tree.insert(("date", 2))
        
        // When
        var output = ""
        customDump(tree, to: &output)
        
        // Then
        XCTAssertTrue(output.contains("apple: 5"))
        XCTAssertTrue(output.contains("banana: 3"))
        XCTAssertTrue(output.contains("cherry: 8"))
        XCTAssertTrue(output.contains("date: 2"))
        XCTAssertFalse(output.contains("BTreeNode"))
        XCTAssertFalse(output.contains("elements:"))
    }
    
    func testListCustomDumpOutput() {
        // Given
        var list: List<String> = List()
        list.append("alpha")
        list.append("beta")
        list.append("gamma")
        
        // When
        var output = ""
        customDump(list, to: &output)
        
        // Then
        XCTAssertTrue(output.contains("[0]: \"alpha\""))
        XCTAssertTrue(output.contains("[1]: \"beta\""))
        XCTAssertTrue(output.contains("[2]: \"gamma\""))
    }
    
    func testMapCustomDumpOutput() {
        // Given
        var map: Map<Int, String> = Map()
        map.updateValue("first", forKey: 1)
        map.updateValue("second", forKey: 2)
        map.updateValue("third", forKey: 3)
        
        // When
        var output = ""
        customDump(map, to: &output)
        
        // Then
        XCTAssertTrue(output.contains("1: \"first\""))
        XCTAssertTrue(output.contains("2: \"second\""))
        XCTAssertTrue(output.contains("3: \"third\""))
    }
    
    func testNestedStructureWithBTree() {
        // Given
        struct SatelliteData {
            let id: Int
            let readings: BTree<Double, Double>
        }
        
        var readings: BTree<Double, Double> = BTree()
        readings.insert((1.0, 25.5))
        readings.insert((1.5, 26.1))
        readings.insert((2.0, 24.8))
        
        let satellite = SatelliteData(id: 42, readings: readings)
        
        // When
        var output = ""
        customDump(satellite, to: &output)
        
        // Then
        XCTAssertTrue(output.contains("id: 42"))
        XCTAssertTrue(output.contains("1.0: 25.5"))
        XCTAssertTrue(output.contains("1.5: 26.1"))
        XCTAssertTrue(output.contains("2.0: 24.8"))
        XCTAssertTrue(output.contains("SatelliteData"))
    }
    
    func testEmptyBTreeOutput() {
        // Given
        let emptyTree: BTree<String, Int> = BTree()
        
        // When
        var output = ""
        customDump(emptyTree, to: &output)
        
        // Then
        XCTAssertTrue(output.contains("[:]") || output.contains("[]"))
    }
    
    func testBTreeVersusStandardDump() {
        // Given
        var tree: BTree<String, Int> = BTree()
        tree.insert(("key1", 100))
        tree.insert(("key2", 200))
        
        // When
        var customOutput = ""
        customDump(tree, to: &customOutput)
        var standardOutput = ""
        dump(tree, to: &standardOutput)
        
        // Then
        // CustomDump should be more concise
        XCTAssertLessThan(customOutput.count, standardOutput.count)
        
        // CustomDump should not contain internal implementation details
        XCTAssertFalse(customOutput.contains("BTreeNode"))
        XCTAssertFalse(customOutput.contains("_order"))
        XCTAssertFalse(customOutput.contains("_depth"))
        
        // Standard dump should contain these details
        XCTAssertTrue(standardOutput.contains("BTreeNode"))
    }
    
    func testBTreeOrderPreservation() {
        // Given
        var tree: BTree<Int, String> = BTree()
        tree.insert((3, "three"))
        tree.insert((1, "one"))
        tree.insert((2, "two"))
        
        // When
        var output = ""
        customDump(tree, to: &output)
        
        // Then - BTree should maintain sorted order
        let oneIndex = output.range(of: "1: \"one\"")?.lowerBound
        let twoIndex = output.range(of: "2: \"two\"")?.lowerBound
        let threeIndex = output.range(of: "3: \"three\"")?.lowerBound
        
        XCTAssertNotNil(oneIndex)
        XCTAssertNotNil(twoIndex)
        XCTAssertNotNil(threeIndex)
        
        if let one = oneIndex, let two = twoIndex, let three = threeIndex {
            XCTAssertLessThan(one, two)
            XCTAssertLessThan(two, three)
        }
    }
}
