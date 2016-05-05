//
//  PPTableViewSectionInfo.h
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewUserInfo.h"

@class PPTableViewCellInfo;

@interface PPTableViewSectionInfo : PPTableViewUserInfo
@property (nonatomic, assign) CGFloat fHeaderHeight;
@property (nonatomic, assign) CGFloat fFooterHeight;
@property (nonatomic, weak) id makeHeaderTarget;
@property (nonatomic, weak) id makeFooterTatget;
@property (nonatomic, assign) SEL makeHeaderSel;
@property (nonatomic, assign) SEL makeFooterSel;
@property (nonatomic, assign) BOOL bUseDynamicSize;

+ (instancetype)sectionInfoDefault;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle;
+ (instancetype)sectionInfoFooter:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView;
+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView;
+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target;

- (void)setHeaderTitle:(NSString *)headerTitle;
- (void)setFooterTitle:(NSString *)footerTitle;
- (void)setHeaderView:(UIView *)headerView;
- (void)setFooterView:(UIView *)footerView;
- (__kindof UIView *)getHeaderView;
- (__kindof UIView *)getFooterView;

- (NSUInteger)getCellCount;
- (PPTableViewCellInfo *)getCellAt:(NSUInteger)row;
- (void)removeCellAt:(NSUInteger)row;
- (void)addCell:(PPTableViewCellInfo *)cell;

@end
