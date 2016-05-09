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

@protocol PPTableViewDelegate <NSObject>
@optional
- (void)didFinishedLoading:(id)arg1;
- (void)touchesEnded_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesMoved_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesBegan_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesCancelled_TableView:(NSSet *)set withEvent:(UIEvent *)event;
@end

@interface PPTableView : UITableView
@property (nonatomic, weak) id<PPTableViewDelegate> m_delegate;
@end

@interface PPTableViewUserInfo : NSObject
@property (nonatomic, strong) PPTableViewUserInfo *userInfo;

- (id)getUserInfoValueForKey:(NSString *)key;
- (void)addUserInfoValue:(id)value forKey:(NSString *)key;
@end

@interface NSString (PPUtility)
- (CGSize)pp_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
@end

@interface UIView (PPUtility)
- (void)pp_removeAllSubviews;
@end

@interface PPBadgeView : UIImageView
@property (nonatomic, assign) CGFloat m_range;
@property (nonatomic, assign) CGFloat fAddedWidth;
@property (nonatomic, assign) CGFloat fOriginWidth;
@property (nonatomic, assign) CGPoint pOriginPoint;

- (void)setUpView;
- (UILabel *)labelView;
- (void)setValue:(NSUInteger)value;
- (void)setString:(NSString *)string;
@end