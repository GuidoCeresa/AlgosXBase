//
//  AlgosLibView.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlgosBorderLabel.h"

//--Classe statica di libreria per le funzionalità legate alle viste
@interface AlgosLibView : UILabel {
}

#pragma mark - Static variables (extern)

#pragma mark - Label e view con font fisso
//--Costruisce una view che contine la label che contiene il testo indicato
//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (UIView *)creaViewWithTesto:(NSString *)testo;

//--Calcola l'altezza di una label per contenere il testo indicato
//--Usa il metodo dedicato -creaLabelWithTesto-
//--La larghezza è fissa. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (CGFloat)altezzaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza;

//--Calcola l'altezza di una label per contenere il testo indicato
//--Usa il metodo dedicato -creaLabelWithTesto-
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (CGFloat)altezzaLabelWithTesto:(NSString *)testo;

//--Costruisce una label per contenere il testo indicato
//--La larghezza è fissa. Il fontSize è fisso.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza fontSize:(NSNumber *)size;

//--Costruisce una label per contenere il testo indicato
//--La larghezza è fissa. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza;

//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è fisso.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo fontSize:(NSNumber *)size;

//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo;


@end
