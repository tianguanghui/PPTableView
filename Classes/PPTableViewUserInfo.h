//
//  PPTableViewUserInfo.h
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/4.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPTableViewUserInfo : NSObject
@property (nonatomic, strong) PPTableViewUserInfo *userInfo;

- (__kindof instancetype)getUserInfoValueForKey:(NSString *)key;
- (void)addUserInfoValue:(id)value forKey:(NSString *)key;
@end
