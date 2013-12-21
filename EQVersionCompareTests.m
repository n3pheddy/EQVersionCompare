//
//  EQVersionCompareTests.m
//  EQVersionCompareTests
//
//  Created by Nephilim Faustus on 21/12/13.
//  Copyright (c) 2013 Nephilim Faustus. All rights reserved.
//

#import "EQVersionCompareTests.h"
#import "EQVersionCompare.h"

@implementation EQVersionCompareTests

- (NSString *)stringFromResult:(NSComparisonResult)comparisonResult {
  switch (comparisonResult) {
    case NSOrderedAscending: {
      return @"is smaller than";
      break;
    }
    case NSOrderedDescending: {
      return @"is greater than";
      break;
    }
    case NSOrderedSame: {
      return @"is equal to";
      break;
    }
  }
  
  return nil;
}

- (void)printComparisonResultOfVersion:(NSString *)previousVersion
                                  with:(NSString *)currentVersion {
  NSComparisonResult comparisonResult = [EQVersionCompare compareVersion:previousVersion
                                                                    with:currentVersion];
  NSLog(@"*** %@ %@ %@ ***",
        previousVersion,
        [self stringFromResult:comparisonResult],
        currentVersion);
}

- (void)testVersionComparison {
  [self printComparisonResultOfVersion:@"1.3.0" with:@"1.3.0"];
  [self printComparisonResultOfVersion:@"1.3.0" with:@"1.3.1"];
  [self printComparisonResultOfVersion:@"1.3.0" with:@"1.2.9"];
  [self printComparisonResultOfVersion:@"1.3.0" with:@"1.3.0.1"];
  [self printComparisonResultOfVersion:@"1.3.0.0" with:@"1.3.0"];
  [self printComparisonResultOfVersion:@"1.3.0A" with:@"1.3.0B"];
  [self printComparisonResultOfVersion:@"1.3.100" with:@"1.3.1"];
  [self printComparisonResultOfVersion:@"..3.100" with:@"1..3."];
  [self printComparisonResultOfVersion:@".a.3.100" with:@"b.1.3."];
}

@end
