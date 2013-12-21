//
//  EQVersionCompare.m
//  EQVersionCompare
//
//  Created by Nephilim Faustus on 21/12/13.
//  Copyright (c) 2013 Nephilim Faustus. All rights reserved.
//

#import "EQVersionCompare.h"

// Uncomment following line to display verbose output
// #define __EQVERSIONCOMPARE_VERBOSE__

@implementation EQVersionCompare

+ (NSComparisonResult)compareVersion:(NSString *)previousVersion
                                with:(NSString *)currentVersion {
  NSScanner *firstScanner = [[NSScanner alloc] initWithString:previousVersion];
  NSScanner *secondScanner = [[NSScanner alloc] initWithString:currentVersion];
  
  NSCharacterSet *charactersToBeSkipped = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
  
  firstScanner.charactersToBeSkipped = charactersToBeSkipped;
  secondScanner.charactersToBeSkipped = charactersToBeSkipped;
  
  NSString *firstBuffer, *secondBuffer;
  NSInteger firstValue, secondValue;
  
  BOOL firstIsAtEnd = [firstScanner isAtEnd];
  BOOL secondIsAtEnd = [secondScanner isAtEnd];
  
#ifdef __EQVERSIONCOMPARE_VERBOSE__
  char groupIndex = 0;
#endif
  
  while (!firstIsAtEnd || !secondIsAtEnd) {
    if (firstIsAtEnd) {
      firstValue = 0;
    }
    else {
      [firstScanner scanUpToString:@"." intoString:&firstBuffer];
      firstValue = firstBuffer.integerValue;
      
      // Skip the period.
      [firstScanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet]
                                   intoString:nil];
    }
    
    if (secondIsAtEnd) {
      secondValue = 0;
    }
    else {
      [secondScanner scanUpToString:@"." intoString:&secondBuffer];
      secondValue = secondBuffer.integerValue;
      
      // Skip the full stop.
      [secondScanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet]
                                    intoString:nil];
    }
    
#ifdef __EQVERSIONCOMPARE_VERBOSE__
    NSLog(@"group %d: compare %d to %d", groupIndex, firstValue, secondValue);
    ++groupIndex;
#endif
    
    if (firstValue > secondValue) {
      return NSOrderedDescending;
    }
    else if (firstValue < secondValue) {
      return NSOrderedAscending;
    }
    
    firstIsAtEnd = [firstScanner isAtEnd];
    secondIsAtEnd = [secondScanner isAtEnd];
  }
  
  return NSOrderedSame;
}

@end
