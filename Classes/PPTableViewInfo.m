//
//  PPTableViewInfo.m
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewInfo.h"
#import "PPTableViewSectionInfo.h"
#import "PPTableViewCellInfo.h"
#import "PPUtility.h"

@interface PPTableViewInfo () <UITableViewDelegate, UITableViewDataSource, PPTableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PPTableViewSectionInfo *> *arrSections;
@end

@implementation PPTableViewInfo
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableView = [[UITableView alloc] initWithFrame:frame style:style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _arrSections = @[].mutableCopy;
    }
    return self;
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrSections[section] getCellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"PPTableViewInfo_%zd_%f", cellInfo.cellStyle, cellInfo.fCellHeight];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell) {
        [cell.contentView pp_removeAllSubviews];
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = nil;
        cell.accessoryView = nil;
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:cellInfo.cellStyle reuseIdentifier:identifier];
    }
    if (cellInfo.makeTarget) {
        if ([cellInfo.makeTarget respondsToSelector:cellInfo.makeSel]) {
            NoWarningPerformSelector(cellInfo.makeTarget, cellInfo.makeSel, cell, cellInfo);
        }
        if (cellInfo.bNeedSeperateLine && tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
            if (indexPath.row == 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0.5f)];
                line.backgroundColor = [UIColor grayColor];
                [cell.contentView addSubview:line];
            }
        }
        cellInfo.cell = cell;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        return [_arrSections[section] getUserInfoValueForKey:@"headerTitle"];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        return [_arrSections[section] getUserInfoValueForKey:@"footerTitle"];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if (cellInfo.editStyle != UITableViewCellEditingStyleNone) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo  = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if ([_delegate respondsToSelector:@selector(commitEditingForRowAtIndexPath:cell:)]) {
                [_delegate commitEditingForRowAtIndexPath:indexPath cell:cellInfo];
            }
        }
    }
}

#pragma mark - UITableView Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        PPTableViewSectionInfo *sectionInfo = _arrSections[section];
        id target = sectionInfo.makeHeaderTarget;
        if (target) {
            if ([target respondsToSelector:sectionInfo.makeHeaderSel]) {
                return NoWarningPerformSelector(target, sectionInfo.makeHeaderSel, sectionInfo, nil);
            } else {
                NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
                if (headerTitle) {
                    return [PPTableViewInfo genHeaderView:headerTitle andIsUseDynamic:sectionInfo.bUseDynamicSize];
                }
            }
        } else {
            UIView *headerView =  [sectionInfo getUserInfoValueForKey:@"header"];
            if (headerView) {
                return headerView;
            } else if ([_delegate respondsToSelector:sectionInfo.makeHeaderSel]) {
                return NoWarningPerformSelector(_delegate, sectionInfo.makeHeaderSel, sectionInfo, nil);
            } else {
                NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
                if (headerTitle) {
                    return [PPTableViewInfo genHeaderView:headerTitle andIsUseDynamic:sectionInfo.bUseDynamicSize];
                }
            }
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        PPTableViewSectionInfo *sectionInfo = _arrSections[section];
        id target = sectionInfo.makeFooterTatget;
        if (target) {
            if ([target respondsToSelector:sectionInfo.makeFooterSel]) {
                return NoWarningPerformSelector(target, sectionInfo.makeFooterSel, sectionInfo, nil);
            } else {
                NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
                if (footerTitle) {
                    return [PPTableViewInfo genFooterView:footerTitle];
                }
            }
        } else {
            UIView *footerView =  [sectionInfo getUserInfoValueForKey:@"footer"];
            if (footerView) {
                return footerView;
            } else if ([_delegate respondsToSelector:sectionInfo.makeFooterSel]) {
                return NoWarningPerformSelector(_delegate, sectionInfo.makeFooterSel, sectionInfo, nil);
            } else {
                NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
                if (footerTitle) {
                    return [PPTableViewInfo genFooterView:footerTitle];
                }
            }
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
        if (headerTitle) {
            return [headerTitle pp_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:_tableView.bounds.size.width maxHeight:CGFLOAT_MAX].height;
        } else {
            PPTableViewSectionInfo *sectionInfo = _arrSections[section];
            if (!sectionInfo.makeHeaderTarget) {
                return sectionInfo.fHeaderHeight;
            } else {
                UIView *headerView = [sectionInfo getUserInfoValueForKey:@"header"];
                if (headerView) {
                    return headerView.frame.size.height;
                } else {
                    return sectionInfo.fHeaderHeight;
                }
            }
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
        if (footerTitle) {
            return [footerTitle pp_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:_tableView.bounds.size.width maxHeight:CGFLOAT_MAX].height;
        } else {
            PPTableViewSectionInfo *sectionInfo = _arrSections[section];
            if (sectionInfo.makeFooterTatget) {
                return sectionInfo.fFooterHeight;
            } else {
                UIView *footerView = [sectionInfo getUserInfoValueForKey:@"footer"];
                if (footerView) {
                    return footerView.frame.size.height;
                } else {
                    return sectionInfo.fFooterHeight;
                }
            }
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        if (indexPath.row < [_arrSections[indexPath.section] getCellCount]) {
            PPTableViewCellInfo *cellInfo = [_arrSections[indexPath.section] getCellAt:indexPath.row];
            id target = cellInfo.calHeightTarget;
            if (target && [target respondsToSelector:cellInfo.calHeightSel]) {
                NoWarningPerformSelector(target, cellInfo.calHeightSel, cellInfo, nil);
            }
            return cellInfo.fCellHeight;
        }
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo && cellInfo.selectionStyle != UITableViewCellSelectionStyleNone) {
            id target = cellInfo.actionTarget;
            if (target) {
                if ([target respondsToSelector:cellInfo.actionSel]) {
                    NoWarningPerformSelector(target, cellInfo.actionSel, cellInfo ,nil);
                }
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if ([_delegate respondsToSelector:@selector(accessoryButtonTappedForRowWithIndexPath:cell:)]) {
                [_delegate accessoryButtonTappedForRowWithIndexPath:indexPath cell:cellInfo];
            }
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            return cellInfo.editStyle;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _arrSections.count) {
        PPTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if (cellInfo.editStyle != UITableViewCellEditingStyleNone) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

#pragma mark - PPTableViewDelegate
- (void)touchesBegan_TableView:(NSSet *)set withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(touchesBegan_TableView:withEvent:)]) {
        [_delegate touchesBegan_TableView:set withEvent:event];
    }
}

- (void)touchesMoved_TableView:(NSSet *)set withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(touchesMoved_TableView:withEvent:)]) {
        [_delegate touchesMoved_TableView:set withEvent:event];
    }
}

- (void)touchesEnded_TableView:(NSSet *)set withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(touchesEnded_TableView:withEvent:)]) {
        [_delegate touchesEnded_TableView:set withEvent:event];
    }
}

- (void)touchesCancelled_TableView:(NSSet *)set withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(touchesCancelled_TableView:withEvent:)]) {
        [_delegate touchesCancelled_TableView:set withEvent:event];
    }
}

- (void)didFinishedLoading:(id)arg1
{
    if ([_delegate respondsToSelector:@selector(didFinishedLoading:)]) {
        [_delegate didFinishedLoading:arg1];
    }
}

#pragma mark - Section
- (void)addSection:(PPTableViewSectionInfo *)section
{
    [_arrSections addObject:section];
}

- (void)clearAllSection
{
    [_arrSections removeAllObjects];
}

- (void)removeSectionAt:(NSUInteger)section
{
    if (_arrSections.count < section) {
        return;
    }
    [_arrSections removeObjectAtIndex:section];
    [_tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSUInteger)getSectionCount
{
    return _arrSections.count;
}

- (PPTableViewSectionInfo *)getSectionAt:(NSUInteger)section
{
    if (section < _arrSections.count) {
        return _arrSections[section];
    }
    return nil;
}

#pragma mark - Cell
- (PPTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row
{
    if (_arrSections.count >= section && [_arrSections[section] getCellCount] >= row) {
        return [_arrSections[section] getCellAt:row];
    } else {
        return nil;
    }
}

- (void)removeCellAt:(NSIndexPath *)indexPath
{
    PPTableViewSectionInfo *sectionInfo = [self getSectionAt:indexPath.section];
    [sectionInfo removeCellAt:indexPath.row];
    if ([sectionInfo getCellCount]) {
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self removeSectionAt:indexPath.section];
    }
}

- (UITableView *)getTableView
{
    return _tableView;
}

+ (UIView *)genHeaderView:(NSString *)headerTitle andIsUseDynamic:(BOOL)dynamic
{
    return [self createHeaderOrFooterViewWithTitle:headerTitle];
}

+ (UIView *)genFooterView:(NSString *)footerTitle
{
    return [self createHeaderOrFooterViewWithTitle:footerTitle];
}

+ (UIView *)createHeaderOrFooterViewWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor grayColor];
    label.text = title;
    label.numberOfLines = 0;
    label.frame = (CGRect){{15.0f, 0}, [title pp_sizeWithFont:label.font maxWidth:[UIScreen mainScreen].bounds.size.width maxHeight:CGFLOAT_MAX]};
    [view addSubview:label];
    view.frame = CGRectMake(0, 0, 0, CGRectGetHeight(label.frame));
    return view;
}

@end
