//
//  EQVersionCompare.h
//  EQVersionCompare
//
//  Created by Nephilim Faustus on 21/12/13.
//  Copyright (c) 2013 Nephilim Faustus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(char, EQVersionCompareResult) {
  EQVersionCompareSmaller = NSOrderedAscending,
  EQVersionCompareGreater = NSOrderedDescending,
  EQVersionCompareSame = NSOrderedSame
};

@interface EQVersionCompare : NSObject

+ (NSComparisonResult)compareVersion:(NSString *)previousVersion
                                with:(NSString *)currentVersion;

@end
