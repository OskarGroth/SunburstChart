//
//  ChartDataSource.swift
//  SunburstChart
//
//  Created by Oskar Groth on 2019-01-11.
//  Copyright © 2019 Oskar Groth. All rights reserved.
//

import Foundation

public class ChartDataSource: NSObject {
    
    public fileprivate(set) var sections: [ChartSection]
    fileprivate weak var chartView: SBChartView?
    fileprivate let processingQueue = OperationQueue()
    
    /// The designated initializer
    ///
    /// - Parameter sections: The initial Chart View sections.
    public init(sections: [ChartSection] = []) {
        self.sections = sections
        processingQueue.maxConcurrentOperationCount = 1
        super.init()
    }
    
    /// Sets new sections on the data source and reloads the Chart View.
    ///
    /// - Parameter newSections: The new sections to set.
    public func reloadData(newSections: [ChartSection]) {
        sections = newSections
        chartView?.reloadData()
    }
    
    /// Sets new sections on the Chart View, optionally animating the changes.
    ///
    /// - Parameters:
    ///     - newSections: The new sections to set.
    ///     - animation: When set to anything other than `.none`, computes and animates the changes from the current sections. Defaults to `.automatic`
    ///     - completion: Run when the new sections have been applied.
    public func updateSections(to newSections: [ChartSection]/*, animation: UITableView.RowAnimation = .fade,*/, completion: @escaping (() -> Void) = {}) {
        
        //guard animation != .none else {
            reloadData(newSections: newSections)
           /* completion()
            return
        }
        
        // Animated track, let's calculate some changes!
        let processingOperation = BlockOperation()
        processingOperation.addExecutionBlock { [unowned processingOperation, weak self] in
            guard let strongSelf = self else { return } // Not interesting if we already have been deallocated
            
            // Compute changes if necessary for animation
            let changeSet = StagedChangeset(source: strongSelf.sections, target: newSections)
            
            guard !processingOperation.isCancelled else { return }
            
            DispatchQueue.main.sync { // Dispatch sync to make sure our changes are applied before any more are incoming
                
                // Make sure we're actually the table view's data source before trying to update it
                guard strongSelf.isCurrentDataSource else { return }
                guard let tableView = strongSelf.tableView else { return }
                guard !changeSet.isEmpty else { return }
                
                strongSelf.ignoreDidEndDisplayingCells = true
                tableView.applyChanges(
                    using: changeSet,
                    rowAnimation: animation,
                    setData: { sections in
                        strongSelf.sections = sections
                },
                    updateHandler: { cell, model, _ in
                        model.cellConfigurator?(tableView, cell)
                }
                )
                strongSelf.ignoreDidEndDisplayingCells = false
            }
        }
        
        processingOperation.completionBlock = completion
        processingQueue.cancelAllOperations() // If user spams UI, and toggles state back and forth, make sure to cancel old state changes and just process the most recent complete state
        processingQueue.addOperation(processingOperation)*/
    }
    
    /// Setups the provided Chart View for use with this datasource
    public func setup(with chartView: SBChartView) {
        self.chartView = chartView
        
        chartView.dataSource = self
        chartView.reloadData()
        //tableView.dataSource = self
        //tableView.delegate = self
        //tableView.reloadData()
    }
    
    /// Finds the index path of the row with a certain identifier.
    ///
    /// - Parameter identifier: The identifier to find.
    /// - Returns: The index path of the row, or `nil` if none was found.
    public func indexPathForRow(identifiedBy identifier: String) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            if let row = section.items.index(where: { $0.identifier == identifier }) {
                return IndexPath(item: row, section: sectionIndex)
            }
        }
        
        return nil
    }
    
}

extension ChartDataSource: ChartViewDataSource {
    
    public func numberOfSections(in: SBChartView) -> Int {
        return sections.count
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return sections[section].items.count
    }
    
    public func chartView(_ chartView: SBChartView, nodeForRowAt indexPath: IndexPath) -> ChartNode {
        let nodeModel = sections[indexPath.section].items[indexPath.item]
        //cellModel.cellReuseRegistrator?(tableView)
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellReuseIdentifier, for: indexPath)
        print("Created a node for \(indexPath)")
        let node = ChartNode()
        nodeModel.nodeConfigurator?(chartView, node)
        return node
    }
    
    
}
