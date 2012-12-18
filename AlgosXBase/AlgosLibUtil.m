//
//  AlgosLibUtil.m
//  AlgosXBase
//
//  Created by Marco Velluto on 27/10/12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "AlgosLibUtil.h"

@implementation AlgosLibUtil

#pragma mark - Metodi Dizionario
//--Restituisce un booleano dal dizionario
+ (BOOL)boolValueFromDict:(NSDictionary *)dict forKey:(NSString *)key {
    BOOL booleano;
    NSNumber *num;
    NSNumber *zero = [[NSNumber alloc] initWithBool:false];
    
    if (dict) {
        num = [dict valueForKey:key];
        if ([num isEqualToNumber:zero]) {
            booleano = false;
        } else {
            booleano = true;
        }
    }
    return booleano;
}

//--Ordina un array di dizionari secondo il campo indicato
//--Spazzola l'array
//--Recupera il dizionario
//--Estrae il valore della chiave
//--Crea una mappa temporanea chiave/dizionario
//--Crea una lista di chiavi della mappa
//--Ordina la lista di chiavi
//--Spazzola la lista di chiavi
//--Recupera il dizionario dalla mappa temporanea
//--Aggiunge il dizionario ad un array provvisorio
//--Restituisce l'array
+ (NSArray *)ordinaListaDizionari:(NSArray *)arrayIn forKey:(NSString *)key {
    NSArray *arrayOut;
    NSMutableArray *arrayTmp = [[NSMutableArray alloc] init];
    NSArray *listaChiavi = [[NSArray alloc] init];
    NSObject *obj;
    NSDictionary *dic;
    NSMutableDictionary *mappa = [[NSMutableDictionary alloc] init];;
    NSString *chiave;
    
    if (arrayIn) {
        for (obj in arrayIn) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                dic = (NSDictionary *)obj;
                if ([dic objectForKey:key]) {
                    chiave = [dic objectForKey:key];
                    [mappa setObject:dic forKey:chiave];
                }
            }
            
        }
        listaChiavi = [mappa allKeys];
        listaChiavi = [listaChiavi sortedArrayUsingSelector:@selector(compare:)];
        for (chiave in listaChiavi) {
            [arrayTmp addObject:[mappa objectForKey:chiave]];
        }
    }
    arrayOut = arrayTmp;
    return arrayOut;
}

//--Ordina un array di dizionari secondo il campo chiave
+ (NSArray *)ordinaListaDizionari:(NSArray *)arrayIn {    
    return [AlgosLibUtil ordinaListaDizionari:arrayIn forKey:@"chiave"];
}

#pragma mark - Metodi Ordinamento
+ (NSArray *)inverterOrderArray:(NSArray *)arrayIn {
    
    NSMutableArray *arrayOut = [[NSMutableArray alloc] init];
    int count = arrayIn.count - 1;
    while (count != -1) {
        
        [arrayOut addObject:[arrayIn objectAtIndex:count]];
        count --;
    }
    return arrayOut;
}

+ (NSArray *)ordinaVettoreAlfabeticamente:(NSArray *)array {
    
    int i = 0;
    NSMutableArray *ritorno;
    
    for (bool k = true; k; ) {
        
        for (NSString *str in array) {
            
            if (str < [array objectAtIndex:i+1]){
                
                [ritorno addObject:str];
                k = false;
            }
            else
                [ritorno addObject:[array objectAtIndex:i+1]];
            
            i++;
        }
        
        array = ritorno;
    }
    return ritorno;
}

+ (NSString *)creaOggettoStringa:(int)numero {
    
    NSString *str = [[NSString alloc] init];
    str = [NSString stringWithFormat:@"%i", numero];
    return str;
}

+ (void)stampaArray:(NSArray *)array {
    
    NSLog(@"_________ INIZIO _________");
    for (NSString *str in array) {
        
        NSLog(@"%@", str);
    }
    NSLog(@"__________ FINE __________");
}

+ (NSString *)generaStringaDaArray:(NSArray *)array {
    
    NSString *str = [[NSString alloc] init];
    
    for (NSString *strTemp in array) {
        
        str = [str stringByAppendingString:strTemp];
    }
    return str;
}

+ (double)funzionePotenza:(int)potenza numero:(double)numero {
    
    int numeroOut = numero;
    for (int i=0; i<potenza-1; i++) {
        
        numeroOut *= numero;
    }
    return numeroOut;
}

+ (int)convertCharToInt:(char)charValue {
    
    return (int) (charValue - '0');
    
}


@end