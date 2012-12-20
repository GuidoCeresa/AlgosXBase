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

//--nomi delle opzioni = chiavi ordinate del dizionario parametri
@property (nonatomic, retain) NSArray *opzioni;

//--testo selezionato di ogni opzione
@property (nonatomic, retain) NSMutableArray *testoOpzioni;

//--valore selezionato di ogni opzione
@property (nonatomic, retain) NSMutableArray *valoreOpzioni;

//--valori di tutti i parametri e delle opzioni per ciascuno
@property (nonatomic, retain) NSDictionary *parametri;


- (IBAction)openInfoScheda:(id)sender;
- (UIView *)footerViewWithTesto:(NSString *)testo colore:(UIColor *)colore font:(UIFont *)font dettaglio:(NSString *)dettaglio;
- (int)getValoreForOpzione:(int)posOpzione;
- (int)getValoreOpzioni;

@end
