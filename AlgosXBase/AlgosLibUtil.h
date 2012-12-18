//
//  AlgosLibUtil.h
//  AlgosXBase
//
//  Created by Marco Velluto on 27/10/12.
//  Copyright (c) 2012 algos. All rights reserved.

#import <Foundation/Foundation.h>

@interface AlgosLibUtil : NSObject

#pragma mark - Metodi Dizionario
//--Restituisce un booleano dal dizionario
+ (BOOL)boolValueFromDict:(NSDictionary *)dict forKey:(NSString *)key;

//--Ordina un array di dizionari secondo il campo indicato
+ (NSArray *)ordinaListaDizionari:(NSArray *)arrayIn forKey:(NSString *)key;

//--Ordina un array di dizionari secondo il campo chiave
+ (NSArray *)ordinaListaDizionari:(NSArray *)arrayIn;

#pragma mark - Metodi Ordinamento
//Restituisce un array con gli elementi invertiti
+ (NSArray *)inverterOrderArray:(NSArray *)arrayIn;

/*Restituisce un vettore ordinato alfabeticamente.
 Il vettore deve essere formato da oggetti di tipo
 NSString */
+ (NSArray *)ordinaVettoreAlfabeticamente:(NSArray *)array;

//Genera un oggetto di tipo stringa dato un numero intero
+ (NSString *)creaOggettoStringa:(int)numero;

//Stampa un array di stringhe
+ (void)stampaArray:(NSArray *)array;

//Genera una stringa formata da tutti gli elementi dell'array
+ (NSString *)generaStringaDaArray:(NSArray *)array;

//Calcola la potenza di un numero intero
+ (double)funzionePotenza:(int)potenza numero:(double)numero;

//Converte un carattere numerico ('3') char in un intero (3)
+ (int)convertCharToInt:(char)charValue;

@end
