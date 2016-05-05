//
//  PPTableViewSectionInfo.m
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewSectionInfo.h"

@interface PPTableViewSectionInfo ()
@property (nonatomic, strong) NSMutableArray<PPTableViewCellInfo *> *arrCells;
@end

@implementation PPTableViewSectionInfo
+ (instancetype)sectionInfoDefault
{
    return [[PPTableViewSectionInfo alloc] init];
}

+ (instancetype)sectionInfoHeader:(NSString *)headerTitle
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:10.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoFooter:(NSString *)footerTitle
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:10.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:10.0f];
    }
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:10.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerView forKey:@"header"];
    [sectionInfo setFHeaderHeight:headerView.frame.size.height];
    return sectionInfo;
}

+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerView forKey:@"footer"];
    [sectionInfo setFFooterHeight:footerView.frame.size.height];
    return sectionInfo;
}

+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target
{
    PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
    [sectionInfo setMakeHeaderSel:sel];
    [sectionInfo setMakeHeaderTarget:target];
    return sectionInfo;
}

- (instancetype)init
{
    if (self = [super init]) {
        _arrCells = @[].mutableCopy;
    }
    return self;
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    [self addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [self setFHeaderHeight:20.0f];
    }
}

- (void)setFooterTitle:(NSString *)footerTitle
{
    [self addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [self setFFooterHeight:20.0f];
    }
}

- (void)setHeaderView:(UIView *)headerView
{
    [self addUserInfoValue:headerView forKey:@"header"];
    [self setFHeaderHeight:headerView.frame.size.height];
}

- (void)setFooterView:(UIView *)footerView
{
    [self addUserInfoValue:footerView forKey:@"footer"];
    [self setFFooterHeight:footerView.frame.size.height];
}

- (UIView *)getHeaderView
{
    return [self getUserInfoValueForKey:@"header"];
}

- (UIView *)getFooterView
{
    return [self getUserInfoValueForKey:@"footer"];
}

- (NSUInteger)getCellCount
{
    return _arrCells.count;
}

- (PPTableViewCellInfo *)getCellAt:(NSUInteger)row
{
    if (_arrCells.count >= row) {
        return _arrCells[row];
    } else {
        return nil;
    }
}

- (void)addCell:(PPTableViewCellInfo *)cell
{
    [_arrCells addObject:cell];
}

- (void)removeCellAt:(NSUInteger)row
{
    [_arrCells removeObjectAtIndex:row];
}

@end
