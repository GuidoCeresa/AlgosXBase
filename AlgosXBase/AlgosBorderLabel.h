//
//  AlgosBorderLabel.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlgosBorderLabel : UILabel
{
    CGFloat topInset;
    CGFloat leftInset;
    CGFloat bottomInset;
    CGFloat rightInset;
}

@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat bottomInset;
@property (nonatomic) CGFloat rightInset;

#pragma mark - Costruttori
//--Costruisce una label con il frame indicato
//--Regola gli inset sinistro e destro col valore di default di 5
- (id)initWithFrameInsetDefault:(CGRect)labelFrame;

@end
