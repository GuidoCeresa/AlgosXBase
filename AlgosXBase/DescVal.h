//
//  DescVal.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 3-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DescVal : NSObject {
    NSString *descrizione;
    NSString *detail;
    NSNumber *valore;
    BOOL check;
    int intValue;
}

@property (nonatomic, retain) NSString *descrizione;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) NSNumber *valore;
@property (nonatomic) BOOL check;
@property (nonatomic) int intValue;

@end
