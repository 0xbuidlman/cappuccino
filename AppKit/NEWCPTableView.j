@import <AppKit/CPControl.j>

var CPTableViewDataSource_tableView_setObjectValue_forTableColumn_row_                                  = 1 << 2  

    CPTableViewDataSource_tableView_acceptDrop_row_dropOperation_                                       = 1 << 3,
    CPTableViewDataSource_tableView_namesOfPromisedFilesDroppedAtDestination_forDraggedRowsWithIndexes_ = 1 << 4,
    CPTableViewDataSource_tableView_validateDrop_proposedRow_proposedDropOperation_                     = 1 << 5,
    CPTableViewDataSource_tableView_writeRowsWithIndexes_toPasteboard_                                  = 1 << 6,

    CPTableViewDataSource_tableView_sortDescriptorsDidChange_                                           = 1 << 7;
    
var CPTableViewDelegate_selectionShouldChangeInTableView_                                               = 1 << 0,
    CPTableViewDelegate_tableView_dataViewForTableColumn_row_                                           = 1 << 1,
    CPTableViewDelegate_tableView_didClickTableColumn_                                                  = 1 << 2,
    CPTableViewDelegate_tableView_didDragTableColumn_                                                   = 1 << 3,
    CPTableViewDelegate_tableView_heightOfRow_                                                          = 1 << 4,
    CPTableViewDelegate_tableView_isGroupRow_                                                           = 1 << 5,
    CPTableViewDelegate_tableView_mouseDownInHeaderOfTableColumn_                                       = 1 << 6,
    CPTableViewDelegate_tableView_nextTypeSelectMatchFromRow_toRow_forString_                           = 1 << 7,
    CPTableViewDelegate_tableView_selectionIndexesForProposedSelection_                                 = 1 << 8,
    CPTableViewDelegate_tableView_shouldEditTableColumn_row_                                            = 1 << 9,
    CPTableViewDelegate_tableView_shouldSelectRow_                                                      = 1 << 10,
    CPTableViewDelegate_tableView_shouldSelectTableColumn_                                              = 1 << 11,
    CPTableViewDelegate_tableView_shouldShowViewExpansionForTableColumn_row_                            = 1 << 12,
    CPTableViewDelegate_tableView_shouldTrackView_forTableColumn_row_                                   = 1 << 13,
    CPTableViewDelegate_tableView_shouldTypeSelectForEvent_withCurrentSearchString_                     = 1 << 14,
    CPTableViewDelegate_tableView_toolTipForView_rect_tableColumn_row_mouseLocation_                    = 1 << 15,
    CPTableViewDelegate_tableView_typeSelectStringForTableColumn_row_                                   = 1 << 16,
    CPTableViewDelegate_tableView_willDisplayView_forTableColumn_row_                                   = 1 << 17,
    CPTableViewDelegate_tableViewSelectionDidChange_                                                    = 1 << 18,
    CPTableViewDelegate_tableViewSelectionIsChanging_                                                   = 1 << 19;

// TODO: add docs
CPTableViewSelectionHighlightStyleRegular = 0;
CPTableViewSelectionHighlightStyleSourceList = 1;


@implementation NEWCPTableView : CPControl
{
    id          _dataSource;
    unsigned    _implementedDataSourceMethods;
    CPArray     _tableColumns;

    //Configuring Behavior
    BOOL        _allowsColumnReordering;
    BOOL        _allowsColumnResizing;
    BOOL        _allowsMultipleSelection;
    BOOL        _allowsEmptySelection;

    //Setting Display Attributes
    CGSize		_intercellSpacing;
    float       _rowHeight;
    BOOL        _usesAlternatingRowBackgroundColors;
    unsigned    _selectionHighlightMask;
    unsigned    _currentHighlightedTableColumn;

    unsigned    _numberOfRows;
    unsigned    _numberOfColumns;

}

- (void)_init
{
    //Configuring Behavior
    _allowsColumnReordering = YES;
    _allowsColumnResizing = YES;
    _allowsMultipleSelection = NO;
    _allowsEmptySelection = YES;
    _allowsColumnSelection = NO;
    
    //Setting Display Attributes
    _selectionHighlightMask = CPTableViewSelectionHighlightStyleRegular;
}



- (void)setDataSource:(id)aDataSource
{
    if (_dataSource === aDataSource)
        return;

    _dataSource = aDataSource;
    _implementedDataSourceMethods = 0;

    if (!_dataSource)
        return;

    if (![_dataSource respondsToSelector:@selector(numberOfRowsInTableView:)])
        [CPException raise:CPInternalInconsistencyException
                reason:[aDataSource description] " does not implement numberOfRowsInTableView:."];

    if (![_dataSource respondsToSelector:@selector(tableView:objectValueForTableColumn:row:)])
        [CPException raise:CPInternalInconsistencyException
                reason:[aDataSource description] " does not implement tableView:objectValueForTableColumn:row:"];

    if ([_dataSource respondsToSelector:@selector(tableView:setObjectValue:forTableColumn:row:)])
        _implementedDataSourceMethods |= CPTableViewDataSource_tableView_setObjectValue_forTableColumn_row_;

    if ([_dataSource respondsToSelector:@selector(tableView:setObjectValue:forTableColumn:row:)])
        _implementedDataSourceMethods |= CPTableViewDataSource_tableView_acceptDrop_row_dropOperation_;

    if ([_dataSource respondsToSelector:@selector(tableView:namesOfPromisedFilesDroppedAtDestination:forDraggedRowsWithIndexes:)])
        _implementedDataSourceMethods |= CPTableViewDataSource_tableView_namesOfPromisedFilesDroppedAtDestination_forDraggedRowsWithIndexes_;

    if ([_dataSource respondsToSelector:@selector(tableView:validateDrop:proposedRow:proposedDropOperation:)])
        _implementedDataSourceMethods |= CPTableViewDataSource_tableView_validateDrop_proposedRow_proposedDropOperation_;

    if ([_dataSource respondsToSelector:@selector(tableView:writeRowsWithIndexes:toPasteboard:)])
        _implementedDataSourceMethods |= CPTableViewDataSource_tableView_writeRowsWithIndexes_toPasteboard_;
}

- (id)dataSource
{
    return _dataSource;
}

//Loading Data

    * � reloadData

//Target-action Behavior

    * � setDoubleAction:
    * � doubleAction
    * � clickedColumn
    * � clickedRow

//Configuring Behavior

� (void)setAllowsColumnReordering:(BOOL)allowsColumnReordering
{
    _allowsColumnReordering = allowsColumnReordering;
}

� (BOOL)allowsColumnReordering
{
    return _allowsColumnReordering;
}

� (void)setAllowsColumnResizing:(BOOL)allowsColumnResizing
{
    _allowsColumnResizing = allowsColumnResizing;
}

� (BOOL)allowsColumnResizing
{
    return _allowsColumnResizing;
}

� (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
}


� (BOOL)allowsMultipleSelection
{
    return _allowsMultipleSelection;
}

� (void)setAllowsEmptySelection:(BOOL)allowsEmptySelection
{
    _allowsEmptySelection = allowsEmptySelection;
}

� (BOOL)allowsEmptySelection
{
    return _allowsEmptySelection;
}

� (void)setAllowsColumnSelection:(BOOL)allowsColumnSelection
{
    _allowsColumnSelection = allowsColumnSelection;
}

� (BOOL)allowsColumnSelection
{
    return allowsColumnSelection;
}

//Setting Display Attributes

� (void)setIntercellSpacing:(CGSize)aSize
{
    if (_intercellSpacing.width != aSize.width)
    {
        var i = 1,
            delta = aSize.width - _intercellSpacing.width;
            total = delta;
        
        for (; i < _tableColumns.length; ++i, total += delta)
        {
            var origin = [_tableColumnViews[i] frame].origin;
            [_tableColumnViews[i] setFrameOrigin:CGPointMake(origin.x + total, origin.y)];
        }
    }

    if (_intercellSpacing.height != aSize.height)
    {
        var i = 0;
        
        for (; i < _tableColumns.length; ++i, total += delta)
        {
            [_tableColumnViews[i] setFrameSize:CGSizeMake([_tableColumnViews[i] width], _numberOfRows * (_rowHeight + _intercellSpacing.height))];
            
            var j = 1,
                y = _rowHeight + _intercellSpacing.height;
            
            for (; j < _numberOfRows; ++i, y += _rowHeight + _intercellSpacing.height)
            {
                if (!_tableCells[i][j])
                    continue;
                
                [_tableCells[i][j] setFrameOrigin:CPPointMake(0.0, y)];
            }
        }
        
        // FIXME: variable height rows
    }

    _intercellSpacing = _CGSizeCreateCopy(aSize);
}

� (CPSize)intercellSpacing
{
    return _intercellSpacing;
}


� (void)setRowHeight:(unsigned)aRowHeight
{
    if (_rowHeight == aRowHeight)
        return;
    
    _rowHeight = aRowHeight;
}

- (unsigned)rowHeight
{
    return _rowHeight;
}



// TODO: confirm: comes from superclass CPView
//� setBackgroundColor:
//� backgroundColor


� (void)setUsesAlternatingRowBackgroundColors:(BOOL)shouldUseAlternatingRowBackgroundColors
{
    // TODO:need to look at how one actually sets the alternating row, a tip at: 
    // http://forums.macnn.com/79/developer-center/228347/nstableview-alternating-row-colors/
    // otherwise this may not be feasible or may introduce an additional change req'd in CP
    // we'd probably need to iterate through rowId % 2 == 0 and setBackgroundColor with 
    // whatever the alternating row color is.
    _usesAlternatingRowBackgroundColors = shouldUseAlternatingRowBackgroundColors;
}

� (BOOL)usesAlternatingRowBackgroundColors
{
    return _usesAlternatingRowBackgroundColors;
}

� (unsigned)selectionHighlightStyle
{
    return _selectionHighlightMask;
}

� (void)setSelectionHighlightStyle:(unsigned)aSelectionHighlightStyle
{
    _selectionHighlightMask = aSelectionHighlightStyle;
}

� setGridColor:


    * � gridColor
    * � setGridStyleMask:
    * � gridStyleMask
    * � indicatorImageInTableColumn:
    * � setIndicatorImage:inTableColumn:

//Column Management

    * � addTableColumn:
    * � removeTableColumn:
    * � moveColumn:toColumn:
    * � tableColumns
    * � columnWithIdentifier:
    * � tableColumnWithIdentifier:

//Selecting Columns and Rows

    * � selectColumnIndexes:byExtendingSelection:
    * � selectRowIndexes:byExtendingSelection:
    * � selectedColumnIndexes
    * � selectedRowIndexes
    * � deselectColumn:
    * � deselectRow:
    * � numberOfSelectedColumns
    * � numberOfSelectedRows
    * � selectedColumn
    * � selectedRow
    * � isColumnSelected:
    * � isRowSelected:
    * � selectAll:
    * � deselectAll:
    * � allowsTypeSelect
    * � setAllowsTypeSelect:

//Table Dimensions

� (int)numberOfColumns
{
    return _numberOfColumns;
}

/*
    Returns the number of rows in the receiver.
*/
� (int)numberOfRows
{
    return _numberOfRows;
}

//Displaying Cell

    * � tableView:willDisplayCell:forTableColumn:row:  delegate method
    * � preparedCellAtColumn:row:
    * � tableView:dataCellForTableColumn:row:  delegate method
    * � tableView:shouldShowCellExpansionForTableColumn:row:  delegate method
    * � tableView:isGroupRow:  delegate method

//Editing Cells

    * � editColumn:row:withEvent:select:
    * � editedColumn
    * � editedRow
    * � tableView:shouldEditTableColumn:row:  delegate method

//Setting Auxiliary Views

    * � setHeaderView:
    * � headerView
    * � setCornerView:
    * � cornerView

//Layout Support

    * � rectOfColumn:
    * � rectOfRow:
    * � rowsInRect:
    * � columnIndexesInRect:
    * � columnAtPoint:
    * � rowAtPoint:
    * � frameOfCellAtColumn:row:
    * � columnAutoresizingStyle
    * � setColumnAutoresizingStyle:
    * � sizeLastColumnToFit
    * � noteNumberOfRowsChanged
    * � tile
    * � sizeToFit
    * � noteHeightOfRowsWithIndexesChanged:
    * � tableView:heightOfRow:  delegate method
    * � columnsInRect: Deprecated in Mac OS X v10.5 

//Drawing

    * � drawRow:clipRect:
    * � drawGridInClipRect:
    * � highlightSelectionInClipRect:
    * � drawBackgroundInClipRect:

//Scrolling

    * � scrollRowToVisible:
    * � scrollColumnToVisible:

//Persistence

    * � autosaveName
    * � autosaveTableColumns
    * � setAutosaveName:
    * � setAutosaveTableColumns:

//Selecting in the Tableview

    * � selectionShouldChangeInTableView:  delegate method
    * � tableView:shouldSelectRow:  delegate method
    * � tableView:selectionIndexesForProposedSelection:  delegate method
    * � tableView:shouldSelectTableColumn:  delegate method
    * � tableViewSelectionIsChanging:  delegate method
    * � tableViewSelectionDidChange:  delegate method
    * � tableView:shouldTypeSelectForEvent:withCurrentSearchString:  delegate method
    * � tableView:typeSelectStringForTableColumn:row:  delegate method
    * � tableView:nextTypeSelectMatchFromRow:toRow:forString:  delegate method

//Setting the Delegate:(id)aDelegate


- (void)setDelegate:(id)aDelegate
{
    if (_delegate === aDelegate)
        return;

    var defaultCenter = [CPNotificationCenter defaultCenter];

    if (_delegate)
    {
        if ([_delegate respondsToSelector:@selector(tableViewColumnDidMove:)])
            [defaultCenter
                removeObserver:_delegate
                          name:CPTableViewColumnDidMoveNotification
                        object:self];

        if ([_delegate respondsToSelector:@selector(tableViewColumnDidResize:)])
            [defaultCenter
                removeObserver:_delegate
                          name:CPTableViewColumnDidResizeNotification
                        object:self];

        if ([_delegate respondsToSelector:@selector(tableViewSelectionDidChange:)])
            [defaultCenter
                removeObserver:_delegate
                          name:CPTableViewSelectionDidChangeNotification
                        object:self];

        if ([_delegate respondsToSelector:@selector(tableViewSelectionIsChanging:)])
            [defaultCenter
                removeObserver:_delegate
                          name:CPTableViewSelectionIsChangingNotification
                        object:self];
    }

    _delegate = aDelegate;
    _implementedDelegateMethods = 0;

    if ([_delegate respondsToSelector:@selector(selectionShouldChangeInTableView:)])
        _implementedDelegateMethods |= CPTableViewDelegate_selectionShouldChangeInTableView_;
    
    if ([_delegate respondsToSelector:@selector(tableView:dataViewForTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_dataViewForTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableView:didClickTableColumn:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_didClickTableColumn_;

    if ([_delegate respondsToSelector:@selector(tableView:didDragTableColumn:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_didDragTableColumn_;

    if ([_delegate respondsToSelector:@selector(tableView:heightOfRow:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_heightOfRow_;

    if ([_delegate respondsToSelector:@selector(tableView:isGroupRow:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_isGroupRow_;

    if ([_delegate respondsToSelector:@selector(tableView:mouseDownInHeaderOfTableColumn:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_mouseDownInHeaderOfTableColumn_;

    if ([_delegate respondsToSelector:@selector(tableView:nextTypeSelectMatchFromRow:toRow:forString:)
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_nextTypeSelectMatchFromRow_toRow_forString_;

    if ([_delegate respondsToSelector:@selector(tableView:selectionIndexesForProposedSelection:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_selectionIndexesForProposedSelection_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldEditTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldEditTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldSelectRow:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldSelectRow_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldSelectTableColumn:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldSelectTableColumn_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldShowViewExpansionForTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldShowViewExpansionForTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldTrackView:forTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldTrackView_forTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableView:shouldTypeSelectForEvent:withCurrentSearchString:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_shouldTypeSelectForEvent_withCurrentSearchString_;

    if ([_delegate respondsToSelector:@selector(tableView:toolTipForView:rect:tableColumn:row:mouseLocation:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_toolTipForView_rect_tableColumn_row_mouseLocation_;

    if ([_delegate respondsToSelector:@selector(tableView:typeSelectStringForTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_typeSelectStringForTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableView:willDisplayView:forTableColumn:row:)])
        _implementedDelegateMethods |= CPTableViewDelegate_tableView_willDisplayView_forTableColumn_row_;

    if ([_delegate respondsToSelector:@selector(tableViewColumnDidMove:)])
        [defaultCenter
            addObserver:_delegate
            selector:@selector(tableViewColumnDidMove:)
            name:CPTableViewColumnDidMoveNotification
            object:self];

    if ([_delegate respondsToSelector:@selector(tableViewColumnDidResize:)])
        [defaultCenter
            addObserver:_delegate
            selector:@selector(tableViewColumnDidMove:)
            name:CPTableViewColumnDidResizeNotification
            object:self];
            
    if ([_delegate respondsToSelector:@selector(tableViewSelectionDidChange:)])
        [defaultCenter
            addObserver:_delegate
            selector:@selector(tableViewSelectionDidChange:)
            name:CPTableViewSelectionDidChangeNotification
            object:self];

    if ([_delegate respondsToSelector:@selector(tableViewSelectionIsChanging:)])
        [defaultCenter
            addObserver:_delegate
            selector:@selector(tableViewSelectionIsChanging:)
            name:CPTableViewSelectionIsChangingNotification
            object:self];
}

- (id)delegate
{
    return _delegate;
}

//Highlightable Column Headers

� (CPTableColumn)highlightedTableColumn
{
    
}

    * � setHighlightedTableColumn:

//Dragging

    * � dragImageForRowsWithIndexes:tableColumns:event:offset:
    * � canDragRowsWithIndexes:atPoint:
    * � setDraggingSourceOperationMask:forLocal:
    * � setDropRow:dropOperation:
    * � setVerticalMotionCanBeginDrag:
    * � verticalMotionCanBeginDrag

//Sorting

    * � setSortDescriptors:
    * � sortDescriptors

//Moving and Resizing Columns

    * � tableView:didDragTableColumn:  delegate method
    * � tableViewColumnDidMove:  delegate method
    * � tableViewColumnDidResize:  delegate method

//Responding to Mouse Events

    * � tableView:didClickTableColumn:  delegate method
    * � tableView:mouseDownInHeaderOfTableColumn:  delegate method
    * � tableView:shouldTrackCell:forTableColumn:row:  delegate method

//Text Delegate Methods

    * � textShouldBeginEditing:
    * � textDidBeginEditing:
    * � textDidChange:
    * � textShouldEndEditing:
    * � textDidEndEditing:

//Displaying Tooltips

    * � tableView:toolTipForCell:rect:tableColumn:row:mouseLocation:  delegate method




@end