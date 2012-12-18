//
//  UIBorderLabel.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 16-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBorderLabel : UILabel {
    CGFloat topInset;
    CGFloat leftInset;
    CGFloat bottomInset;
    CGFloat rightInset;
}

@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat bottomInset;
@property (nonatomic) CGFloat rightInset;

@end
