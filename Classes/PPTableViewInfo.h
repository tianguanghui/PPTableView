//
//  PPTableViewInfo.h
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPUtility.h"

@class PPTableViewSectionInfo;
@class PPTableViewCellInfo;

@protocol PPTableViewInfoDelegate <NSObject, UIScrollViewDelegate, PPTableViewDelegate>
@optional
- (void)commitEditingForRowAtIndexPath:(NSIndexPath *)indexPath cell:(PPTableViewCellInfo *)cellInfo;
- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath cell:(PPTableViewCellInfo *)cellInfo;
@end

@interface PPTableViewInfo : PPTableViewUserInfo
@property (nonatomic, weak) id<PPTableViewInfoDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)addSection:(PPTableViewSectionInfo *)section;
- (void)clearAllSection;
- (void)removeCellAt:(NSIndexPath *)indexPath;
- (void)removeSectionAt:(NSUInteger)section;
- (NSUInteger)getSectionCount;
- (PPTableViewSectionInfo *)getSectionAt:(NSUInteger)section;
- (PPTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row;
- (UITableView *)getTableView;
@end
