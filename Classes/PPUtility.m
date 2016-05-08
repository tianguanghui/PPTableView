//
//  NSString+PPUtility.m
//  PPTableView
//
//  Created by 池鹏鹏 on 16/5/5.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPUtility.h"

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
    label.backgroundColor = [UIColor redColor];
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
    if ([self isPureNumandCharacters:string]) {
        
    } else {
        
    }
    
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    if (string.length <= 1) {
        NSCharacterSet *charecter = [NSCharacterSet decimalDigitCharacterSet];
        string = [string stringByTrimmingCharactersInSet:charecter];
        if (string.length == 0) {
            return YES;
        }
    }
    return NO;
}

- (void)setStringImage:(BOOL)b
{
    
}

@end