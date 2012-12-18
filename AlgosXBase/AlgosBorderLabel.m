//
//  AlgosBorderLabel.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "AlgosBorderLabel.h"

@implementation AlgosBorderLabel

@synthesize topInset;
@synthesize leftInset;
@synthesize bottomInset;
@synthesize rightInset;

#pragma mark - Costruttori
//--Costruisce una label con il frame indicato
//--Regola gli inset sinistro e destro col valore di default di 10
- (id)initWithFrameInsetDefault:(CGRect)labelFrame {
        
    AlgosBorderLabel *label = [super initWithFrame:labelFrame];
    if (label) {
        label.leftInset = 10;
        label.rightInset = 5;
        return label;
    } else {
        return nil;
    }    
}

#pragma mark - View Edit
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {self.topInset, self.leftInset, self.bottomInset, self.rightInset};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
