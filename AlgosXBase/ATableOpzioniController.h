//
//  ATableOpzioniController.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 2-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATableController.h"
#import "ATableDetailController.h"

@interface ATableOpzioniController : ATableController <DetailDelegate> {

}

//--nomi delle sezioni = chiavi ordinate del dizionario parametri
@property (nonatomic, retain) NSArray *sezioni;

//--valori di tutti i parametri e delle opzioni per ciascuno
@property (nonatomic, retain) NSDictionary *parametri;

//--testo selezionato di ogni sezione
@property (nonatomic, retain) NSMutableArray *testoSezioni;

- (IBAction)openInfoScheda:(id)sender;

@end
