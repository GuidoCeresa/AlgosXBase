//
//  AlgosLibView.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "AlgosLibView.h"
#import "AlgosBorderLabel.h"
#import "Const.h"

@implementation AlgosLibView

#pragma mark - Local Variables
//--Valori di default
NSNumber *fontSizeNormaleDefault;
NSNumber *fontSizePiccoloDefault;
NSNumber *larghezzaLabelNormaleDefault;

#pragma mark - Static variables (extern)
//--Inizializzazione chiamata una sola volta
+ (void) initialize {
    static bool done = false;
    
    // This method will be called again if you subclass the class and don't define a initialize method for the subclass
    if(!done) {         
        [AlgosLibView creaDefault];
        
        done = TRUE;
    }
}


#pragma mark - Label e view con font fisso
//--Costruisce una view che contine la label che contiene il testo indicato
//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (UIView *)creaViewWithTesto:(NSString *)testo {
    UIView *view;
    AlgosBorderLabel *label;
    CGRect labelFrame;

    //--crea la label con le esatte dimensioni per il testo
    label = [AlgosLibView creaLabelWithTesto:testo];

    //--regola le dimensioni per la view
    labelFrame = CGRectMake(0, 0, [larghezzaLabelNormaleDefault floatValue], label.frame.size.height);
    view = [[UIView alloc] initWithFrame:labelFrame];

    //--inserisce la label nella view
    [view addSubview:label];
    
    return view;
}

//--Calcola l'altezza di una label per contenere il testo indicato
//--Usa il metodo dedicato -creaLabelWithTesto-
//--La larghezza è fissa. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (CGFloat)altezzaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza {
    CGFloat altezza = 0.0;
    AlgosBorderLabel *label;
    
    label = [AlgosLibView creaLabelWithTesto:testo larga:larghezza];
    if (label) {
        altezza = label.frame.size.height;
    }
    return altezza;
}


//--Calcola l'altezza di una label per contenere il testo indicato
//--Usa il metodo dedicato -creaLabelDaTestoFontFisso-
//--Il numero di caratteri per riga è fisso (sperimentale).
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Calcola il numero di righe necessarie.
//--Calcola l'altezza della label necessaria.
+ (CGFloat)altezzaLabelWithTesto:(NSString *)testo {
    CGFloat altezza = 0.0;
    AlgosBorderLabel *label;
    
    label = [AlgosLibView creaLabelWithTesto:testo];
    if (label) {
        altezza = label.frame.size.height;
    }
    return altezza;
}

//--Costruisce una label per contenere il testo indicato
//--La larghezza è fissa. Il fontSize è fisso.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza fontSize:(NSNumber *)fontSize {
  
    CGRect labelFrame;
    CGFloat altezzaProvvisoriaCheVerraCambiata = 20.0f;
    CGFloat larghezzaFloat = [larghezza floatValue];
    CGFloat fontSizeFloat = [fontSize floatValue];
    CGFloat larghezzaEffettivaTesto;
    CGSize constraintSize;
    CGSize sizeDefinitivo;
    CGFloat outSet = 5; //spazio ESTERNO al testo (sopra e sotto) per espandere un pochino la label in altezza
    
    // Create a label (altezza provvisoria)
    labelFrame = CGRectMake(0, 0, larghezzaFloat, altezzaProvvisoriaCheVerraCambiata);
    AlgosBorderLabel *label = [[AlgosBorderLabel alloc] initWithFrameInsetDefault:labelFrame];
    larghezzaEffettivaTesto = label.frame.size.width - label.leftInset -label.rightInset;
    
    //calcola l'altezza necessaria per il testo
    constraintSize.width = larghezzaEffettivaTesto;
    constraintSize.height = MAXFLOAT;
    sizeDefinitivo = [testo sizeWithFont:[UIFont systemFontOfSize:fontSizeFloat] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    [label setFrame:CGRectMake(0, 0, larghezzaFloat, sizeDefinitivo.height + 2*outSet)];
    label.numberOfLines = 0;

    //setup the label
    [label setFont:[UIFont systemFontOfSize:fontSizeFloat]];
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setText: testo];
    [label setBackgroundColor:[Const instance].grigioCeleste];
   
    return label;
}

//--Costruisce una label per contenere il testo indicato
//--La larghezza è fissa. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo larga:(NSNumber *)larghezza {
    return [AlgosLibView creaLabelWithTesto:testo larga:larghezza fontSize:fontSizeNormaleDefault];
}

//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è fisso.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo fontSize:(NSNumber *)fontSize {
    return [AlgosLibView creaLabelWithTesto:testo larga:larghezzaLabelNormaleDefault fontSize:fontSize];
}

//--Costruisce una label per contenere il testo indicato
//--La larghezza è un valore di default. Il fontSize è un valore di default.
//--Il numero di righe necessarie viene calcolato in automatico.
//--Calcola l'altezza della label necessaria.
+ (AlgosBorderLabel *)creaLabelWithTesto:(NSString *)testo {
    return [AlgosLibView creaLabelWithTesto:testo larga:larghezzaLabelNormaleDefault fontSize:fontSizeNormaleDefault];
}


#pragma mark - Utilitie methods
//--vlori di default
+ (void)creaDefault {
    float deltaIncremento = 1.0;    //--incremento al fontSize di sistema per aumentare la visibilità
    float maxDiminuzione = 1.0;     //--massimo decremento, rispetto al fontSize di sistema, accettato per stringere le label
    
    larghezzaLabelNormaleDefault = [NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width];
    fontSizeNormaleDefault = [NSNumber numberWithFloat:[UIFont systemFontSize] + deltaIncremento];
    fontSizePiccoloDefault = [NSNumber numberWithFloat:[fontSizeNormaleDefault floatValue] - maxDiminuzione];
}

@end
