//
//  PPTableViewCellInfo.h
//  Thebs
//
//  Created by 池鹏鹏 on 16/5/3.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTableViewUserInfo.h"

@interface PPTableViewCellInfo : PPTableViewUserInfo
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) UITableViewCellEditingStyle editStyle;
@property (nonatomic, assign) UITextAutocorrectionType autoCorrectionType;
@property (nonatomic, assign) BOOL bNeedSeperateLine;
@property (nonatomic, assign) SEL makeSel;
@property (nonatomic, assign) SEL actionSel;
@property (nonatomic, assign) SEL calHeightSel;
@property (nonatomic, weak) id makeTarget;
@property (nonatomic, weak) id actionTarget;
@property (nonatomic, weak) id actionTargetForSwitchCell;
@property (nonatomic, weak) id calHeightTarget;
@property (nonatomic, assign) CGFloat fCellHeight;
@property (nonatomic, weak) UITableViewCell *cell;

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue;
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType;

+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge;
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue;
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue imageName:(NSString *)imageName;

+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text;

+ (instancetype)switchCellForSel:(SEL)sel target:(id)target title:(NSString *)title on:(BOOL)on;

+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget height:(CGFloat)height userInfo:(PPTableViewUserInfo *)userInfo;
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(PPTableViewUserInfo *)userInfo;
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget calHeightSel:(SEL)calHeightSel calHeightTarget:(id)calHeightTarget userInfo:(PPTableViewUserInfo *)userInfo;

+ (instancetype)centerCellForSel:(SEL)sel target:(id)target title:(NSString *)title;
@end
