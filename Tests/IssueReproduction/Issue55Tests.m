//
//  Issue55Tests.m
//  UnzipKit
//
//  Created by Dov Frankel on 4/24/17.
//  Copyright © 2017 Abbey Code. All rights reserved.
//

#import "UZKArchiveTestCase.h"
@import UnzipKit;

@interface Issue55Tests : UZKArchiveTestCase

@end

@implementation Issue55Tests

- (void)testWrongFileCountAfterDelete {
    NSArray *allTestFiles = [self.nonZipTestFilePaths.allObjects sortedArrayUsingSelector:@selector(compare:)];
    NSString *inputFilePath = allTestFiles.firstObject;
    NSData *inputData = [NSData dataWithContentsOfFile:inputFilePath];
    NSString *fileNameInZip = inputFilePath.lastPathComponent;
    
    NSURL *testArchiveURL = [self.tempDirectory URLByAppendingPathComponent:@"Issue55Test.zip"];
    
    UZKArchive *archive = [[UZKArchive alloc] initWithURL:testArchiveURL error:nil];
 
    BOOL success = [archive writeData:inputData
                             filePath:fileNameInZip
                             progress:NULL
                                error:NULL];
    XCTAssertTrue(success, @"Failed to write first test file");
    
    NSUInteger fileCount = [archive listFileInfo: NULL].count;
    XCTAssertEqual(fileCount, (uint)1, @"Incorrect initial file count");
    
    success = [archive deleteFile:fileNameInZip error:NULL];
    XCTAssertTrue(success, @"Failed to delete first test file");
    
    fileCount = [archive listFileInfo: NULL].count;
    XCTAssertEqual(fileCount, (uint)0, @"Incorrect file count after delete");

    success = [archive writeData:inputData
                        filePath:fileNameInZip
                        progress:NULL
                           error:NULL];
    XCTAssertTrue(success, @"Failed to write second test file");
    
    fileCount = [archive listFileInfo: NULL].count;
    XCTAssertEqual(fileCount, (uint)1, @"Incorrect file count after re-add");
}

@end
