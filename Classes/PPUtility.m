//
//  NSString+PPUtility.m
//  PPTableView
//
//  Created by 池鹏鹏 on 16/5/5.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPUtility.h"

@interface PPTableViewUserInfo ()
@property (nonatomic, strong) NSMutableDictionary *dicInfo;
@end

@implementation PPTableViewUserInfo
- (id)getUserInfoValueForKey:(NSString *)key
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

@implementation PPTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if (style == UITableViewStyleGrouped) {
            self.backgroundView = nil;
            self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.sectionHeaderHeight = 10.0f;
            self.sectionFooterHeight = 10.0f;
            self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        }
        self.sectionIndexColor = [UIColor darkGrayColor];
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (_m_delegate) {
        if ([_m_delegate respondsToSelector:@selector(touchesBegan_TableView:withEvent:)]) {
            [_m_delegate touchesBegan_TableView:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (_m_delegate) {
        if ([_m_delegate respondsToSelector:@selector(touchesMoved_TableView:withEvent:)]) {
            [_m_delegate touchesMoved_TableView:touches withEvent:event];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (_m_delegate) {
        if ([_m_delegate respondsToSelector:@selector(touchesEnded_TableView:withEvent:)]) {
            [_m_delegate touchesEnded_TableView:touches withEvent:event];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if (_m_delegate) {
        if ([_m_delegate respondsToSelector:@selector(touchesCancelled_TableView:withEvent:)]) {
            [_m_delegate touchesCancelled_TableView:touches withEvent:event];
        }
    }
}

@end

@implementation NSString (PPUtility)
- (CGSize)pp_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    if (self.length) {
        NSDictionary *attributes = @{NSFontAttributeName : font};
        CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
        return [self boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil].size;
    } else {
        return CGSizeZero;
    }
}

@end

@implementation UIView (PPUtility)
- (void)pp_removeAllSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end
@implementation PPBadgeView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.tag = 10032;
    [self addSubview:label];
    _pOriginPoint = CGPointZero;
    _fAddedWidth = 20.0f;
}

- (UILabel *)labelView
{
    return [self viewWithTag:10032];
}

- (void)setValue:(NSUInteger)value
{
    if (value >= 100) {
        [self setString:@(value).stringValue];
    } else {
        [self setString:[NSString stringWithFormat:@"%zd", value]];
    }
}

- (void)setString:(NSString *)string
{
    BOOL isPureNumandCharacters = [self isPureNumandCharacters:string];
    if (isPureNumandCharacters) {
        
    } else {
        
    }
    [self setStringImage:isPureNumandCharacters];
    UILabel *label = [self labelView];
    label.hidden = NO;
    if (isPureNumandCharacters) {
        label.text = string;
    } else {
        label.text = [string lowercaseString];
    }
    [label sizeToFit];
    if (isPureNumandCharacters) {
        self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    } else {
        self.bounds = CGRectMake(0, 0, label.frame.size.width + 20.0f, label.frame.size.height + 20.0f);
    }
    label.center = CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height * 0.5f);
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    if (string.length <= 1) {
        if ([string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length == 0) {
            return YES;
        }
    }
    return NO;
}

- (void)setStringImage:(BOOL)isPureNumandCharacters
{
    NSURL *url = [[NSBundle bundleForClass:[PPTableView class]] URLForResource:@"PPTableView" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"badge@2x" ofType:@"png"]];
    if (isPureNumandCharacters) {
        self.image = image;
    } else {
        self.image = [image stretchableImageWithLeftCapWidth:15.0f topCapHeight:0];
    }
}

@end