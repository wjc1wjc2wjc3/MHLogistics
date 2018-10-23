//
//  Contacts.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "HZBitViewController.h"

@protocol ContactsDelegate<NSObject>

@optional
- (void)selectedContact:(NSString *)phone;

@end

@interface Contacts : NSObject

@property (nonatomic, weak) id<ContactsDelegate> delegate;

- (instancetype)initWithViewController:(HZBitViewController *)vc;

- (void)selectedContact;

@end
