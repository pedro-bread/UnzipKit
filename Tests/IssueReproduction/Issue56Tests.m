//
//  Issue56Tests.m
//  UnzipKit
//
//  Created by Dov Frankel on 4/24/17.
//  Copyright © 2017 Abbey Code. All rights reserved.
//

#import "UZKArchiveTestCase.h"
@import UnzipKit;

@interface Issue56Tests : UZKArchiveTestCase

@end

@implementation Issue56Tests

- (void)testCrashExtractingWithWrongPassword {
    NSSet *expectedFileSet = self.nonZipTestFilePaths;
    NSArray *expectedFiles = [expectedFileSet.allObjects sortedArrayUsingSelector:@selector(compare:)];

    NSURL *testArchiveURL = self.testFileURLs[@"Test Archive (Password).zip"];
    NSString *password = @"hello";
    UZKArchive *archive = [[UZKArchive alloc] initWithURL:testArchiveURL password:password error:nil];

    NSString *fileToExtract = expectedFiles.firstObject;
    NSError *extractionError = nil;
    NSData *extractedData = [archive extractDataFromFile:fileToExtract
                                                progress:NULL
                                                   error:&extractionError];
    XCTAssertNil(extractedData, @"No data extracted for archive with wrong password");
    XCTAssertNotNil(extractionError, @"No error reported for wrong password");
    XCTAssertEqual(extractionError.code, UZKErrorCodeInvalidPassword, @"Wrong error code provided");
}

@end
