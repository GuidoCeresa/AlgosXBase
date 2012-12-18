//
//  UIBorderLabel.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 16-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "UIBorderLabel.h"

@implementation UIBorderLabel

@synthesize topInset, leftInset, bottomInset, rightInset;

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {self.topInset, self.leftInset, self.bottomInset, self.rightInset};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end