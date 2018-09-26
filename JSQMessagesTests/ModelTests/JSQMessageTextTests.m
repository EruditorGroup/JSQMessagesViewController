//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessage.h"


@interface JSQMessageTextTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSAttributedString *attributedText;

@end


@implementation JSQMessageTextTests

- (void)setUp
{
    [super setUp];
    
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Jesse Squires";
    self.date = [NSDate date];
    
    self.attributedText = [[NSAttributedString alloc] initWithString:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
                           @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
                           @"architecto beatae vitae dicta sunt explicabo."];
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    self.attributedText = nil;
    [super tearDown];
}

#pragma mark - Text messages

- (void)testTextMessageInit
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                            attributedText:self.attributedText];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testTextMessageIsEqual
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                            attributedText:self.attributedText];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testTextMessageArchiving
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                            attributedText:self.attributedText];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
