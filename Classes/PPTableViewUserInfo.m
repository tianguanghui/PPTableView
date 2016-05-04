//
//  PPTableViewUserInfo.m
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/4.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewUserInfo.h"

@interface PPTableViewUserInfo ()
@property (nonatomic, strong) NSMutableDictionary *dicInfo;
@end

@implementation PPTableViewUserInfo
- (instancetype)getUserInfoValueForKey:(NSString *)key
{
    if (_dicInfo) {
        return [_dicInfo objectForKey:key];
    }
    return nil;
}

- (void)addUserInfoValue:(id)value forKey:(NSString *)key
{
    if (!_dicInfo) {
        _dicInfo = [[NSMutableDictionary alloc] init];
    }
    if (value) {
        [_dicInfo setObject:value forKey:key];
    }
}

@end
