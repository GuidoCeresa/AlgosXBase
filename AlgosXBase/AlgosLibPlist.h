//
//  AlgosLibPList.h
//  AlgosXBase
//
//  Created by Marco Velluto on 04/10/12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlgosLibPList : NSObject

//--Restituisce un booleano dal dizionario
+ (BOOL)boolValueFromDict:(NSDictionary *)dict forKey:(NSString *)key;

+ (NSArray *)keysFromPlistName:(NSString *)plistName;

+ (BOOL)isEsistePlistForName:(NSString *)plistName;


/*!
 * @abstract Foo is good for bar.
 *
 * @deprecated in version 2.0
 */
+ (NSArray *)arrayFromPlistName:(NSString *)plistName;

//--Recupera dalla pList un array di dati al primo livello
//--La pList NON deve essere un dizionario (al primo livello)
+ (NSArray *)arrayFromPlistWithName:(NSString *)plistName;

+ (NSArray *)arrayFromDictionary:(NSDictionary *)dictionary;
+ (NSDictionary *)dictionaryWithString:(NSString *)name;
+ (NSDictionary *)getDictionaryArticoliFromPlistName:(NSString *)plistName;
+ (void)writeDictionary:(NSDictionary *)dictionary fromPlistName:(NSString *)plistName;
+ (NSDictionary *)readPlistName:(NSString *)plistName;

+ (NSDictionary *)createDictionaryWithObject:(NSObject *)obj andKey:(NSString *)key;
+ (NSString *)pathPlist;

@end
