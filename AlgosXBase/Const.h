//
//  Const.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 1-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Const : NSObject {
    //--colori di sfondo delle label
    UIColor *grigioCeleste;
    UIColor *grigioChiaro;
    UIColor *grigioScuro;
}

@property (nonatomic, retain) UIColor *grigioCeleste;
@property (nonatomic, retain) UIColor *grigioChiaro;
@property (nonatomic, retain) UIColor *grigioScuro;

// message from which our instance is obtained
+ (Const *)instance;

@end
