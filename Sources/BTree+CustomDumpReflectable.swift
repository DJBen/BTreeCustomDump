import BTree
import CustomDump

extension BTree: @retroactive CustomDumpReflectable {
    public var customDumpMirror: Mirror {
        // Convert BTree to an ordered dictionary-like format for dumping
        let children: [(label: String?, value: Any)] = self.map { element in
            return (label: "\(element.0)", value: element.1)
        }
        
        return Mirror(
            self,
            children: children,
            displayStyle: .dictionary,
            ancestorRepresentation: .suppressed
        )
    }
}

extension Map: @retroactive CustomDumpReflectable {
    public var customDumpMirror: Mirror {
        // Convert Map to an ordered dictionary-like format for dumping
        let children: [(label: String?, value: Any)] = self.map { element in
            return (label: "\(element.0)", value: element.1)
        }
        
        return Mirror(
            self,
            children: children,
            displayStyle: .dictionary,
            ancestorRepresentation: .suppressed
        )
    }
}

extension List: @retroactive CustomDumpReflectable {
    public var customDumpMirror: Mirror {
        // Convert List to an ordered array for dumping
        let children: [(label: String?, value: Any)] = self.enumerated().map { index, value in
            return (label: "[\(index)]", value: value)
        }
        
        return Mirror(
            self,
            children: children,
            displayStyle: .collection,
            ancestorRepresentation: .suppressed
        )
    }
}
