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

@interface PPTableViewInfo () <UITableViewDelegate, UITableViewDataSource>
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
    if (cell) {
        [self removeAllSubviewsWithView:cell.contentView];
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = nil;
        cell.accessoryView = nil;
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:cellInfo.cellStyle reuseIdentifier:@"11"];
    }
    cellInfo.cell = cell;
    if ([cellInfo makeTarget]) {
        if ([cellInfo respondsToSelector:[cellInfo makeSel]]) {
            [cellInfo performSelector:[cellInfo makeSel] withObject:cell];
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        PPTableViewSectionInfo *sectionInfo = _arrSections[section];
        id target = sectionInfo.makeHeaderTarget;
        if (target) {
            if ([target respondsToSelector:sectionInfo.makeHeaderSel]) {
                return [target performSelector:sectionInfo.makeHeaderSel withObject:sectionInfo];
            }
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        PPTableViewSectionInfo *sectionInfo = _arrSections[section];
        if (sectionInfo.makeFooterTatget) {
            if ([sectionInfo respondsToSelector:sectionInfo.makeFooterSel]) {
                return [sectionInfo performSelector:sectionInfo.makeFooterSel withObject:sectionInfo];
            }
        }
    }
    return nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < _arrSections.count) {
        NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
        if (headerTitle) {
            return [self labelHeight:headerTitle maxWidth:_tableView.frame.size.width maxHeight:CGFLOAT_MAX font:[UIFont systemFontOfSize:17.0f]];
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
            return [self labelHeight:footerTitle maxWidth:_tableView.frame.size.width maxHeight:CGFLOAT_MAX font:[UIFont systemFontOfSize:17.0f]];
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
                    [target performSelector:cellInfo.actionSel withObject:cellInfo];
                }
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addSection:(PPTableViewSectionInfo *)section
{
    [_arrSections addObject:section];
}

- (void)clearAllSection
{
    [_arrSections removeAllObjects];
}

- (NSUInteger)getSectionCount
{
    return _arrSections.count;
}

- (PPTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row
{
    if (_arrSections.count >= section && [_arrSections[section] getCellCount] >= row) {
        return [_arrSections[section] getCellAt:row];
    } else {
        return nil;
    }
}

- (UITableView *)getTableView
{
    return _tableView;
}

- (CGFloat)labelHeight:(NSString *)text maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font
{
    if (text.length) {
        NSDictionary *attributes = @{NSFontAttributeName : font};
        CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
        return [text boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil].size.height;
    } else {
        return CGFLOAT_MIN;
    }
}

- (void)removeAllSubviewsWithView:(UIView *)view
{
    
}
@end
