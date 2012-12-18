//
//  ATableDetailController.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 3-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATableController.h"

@protocol DetailDelegate <NSObject>

- (void)detailViewTerminated:(NSString *)valoreSelezionato;

@end

@interface ATableDetailController : ATableController {

    //--delegate
    id delegate;
    
    //--array di tipo DescVal
    NSArray *opzioni;
    
    //--valore selezionato (eventuale)
    NSString *valoreSelezionato;

}
//--delegate standard
@property (nonatomic, retain) id delegate;

//--array di tipo DescVal
@property (nonatomic, retain) NSArray *opzioni;

//--valore selezionato (eventuale)
@property (nonatomic, retain) NSString *valoreSelezionato;

@end
