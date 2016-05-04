//
//  PPTableViewInfo.h
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewUserInfo.h"

@class PPTableViewSectionInfo;
@class PPTableViewCellInfo;

@interface PPTableViewInfo : PPTableViewUserInfo

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (void)addSection:(PPTableViewSectionInfo *)section;
- (void)clearAllSection;
- (NSUInteger)getSectionCount;
- (PPTableViewSectionInfo *)getSectionAt:(NSUInteger)section;
- (PPTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row;
- (UITableView *)getTableView;
@end
