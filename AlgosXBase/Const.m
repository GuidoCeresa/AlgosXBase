//
//  Const.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 1-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "Const.h"

//--Singleton - variabili globali
@implementation Const 

#pragma mark - Synthesize Variables
@synthesize grigioCeleste;
@synthesize grigioScuro;
@synthesize grigioChiaro;

#pragma mark - Init
//--Lazy initialization per garantire che la classe sia un Singleton
+ (Const *)instance {
    // the instance of this class is stored here
    static Const *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        
        // initialize variables here
        [myInstance creaColori];
    }
    // return the instance of this class
    return myInstance;
}

#pragma mark - Utilitie methods
//--colori di sfondo
- (void)creaColori {
    double grigio = 210.0;
    double delta = 20.0;
    
    grigioCeleste = [UIColor colorWithRed: 240.0/255.0 green: 245.0/255.0 blue:245.0/255.0 alpha: 1.0];
    
    grigioScuro = [UIColor colorWithRed:grigio/255.0 green:grigio/255.0 blue:grigio/255.0 alpha: 1.0];
    grigioChiaro = [UIColor colorWithRed:(grigio+delta)/255.0 green:(grigio+delta)/255.0 blue:(grigio+delta)/255.0 alpha: 1.0];
}
@end
