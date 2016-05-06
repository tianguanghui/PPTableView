//
//  NSString+PPUtility.h
//  PPTableView
//
//  Created by 池鹏鹏 on 16/5/5.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NoWarningPerformSelector(target, action, object, object1) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object withObject:object1] \
_Pragma("clang diagnostic pop") \

@interface NSString (PPUtility)
- (CGSize)pp_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
@end

@interface UIView (PPUtility)
- (void)pp_removeAllSubviews;
@end

@interface PPCPLabel : UILabel

@end