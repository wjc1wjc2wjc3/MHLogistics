//
//  Contacts.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "Contacts.h"
#import "HZBitPopupView.h"

NSString *const kCountryPrefix = @"+86";


@interface Contacts()<ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate> {
    HZBitViewController *_baseVC;
}
@end

@implementation Contacts

- (instancetype)initWithViewController:(HZBitViewController *)vc {
    if (self = [super init]) {
        _baseVC = vc;
    }
    
    return self;
}

- (void)selectedContact {
    
    if (@available(iOS 12.0, *)) {
        __block BOOL bNext = NO;
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:
            {
                CNContactStore *store = [[CNContactStore alloc] init];
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                    if (!granted) {
                        [MBManager showBriefAlert:LOCALIZEDSTRING(@"can'tReadContact")];
                    }
                    bNext = granted;
                }];
            }
                break;
            case CNAuthorizationStatusRestricted:
            {
                [MBManager showBriefAlert:LOCALIZEDSTRING(@"noRightReadContact")];
            }
                break;
            case CNAuthorizationStatusDenied:
            {
                [MBManager showBriefAlert:LOCALIZEDSTRING(@"readContactWasDeny")];
            }
                break;
            case CNAuthorizationStatusAuthorized:
            {
                bNext = YES;
            }
                break;
            default:
                break;
        }
        
        if (bNext) {
            CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
            contactVc.delegate = self;
            [_baseVC presentViewController:contactVc animated:YES completion:nil];
        }
        
    }
    else
    {
        __block BOOL bNext = NO;
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
                {
                    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                        if (!granted) {
                            [MBManager showBriefAlert:LOCALIZEDSTRING(@"can'tReadContact")];
                        }
                        bNext = granted;
                    });
                    CFRelease(addressBook);
                }
                break;
            case kABAuthorizationStatusRestricted:
            {
                [MBManager showBriefAlert:LOCALIZEDSTRING(@"noRightReadContact")];
            }
                break;
            case kABAuthorizationStatusDenied:
            {
                [MBManager showBriefAlert:LOCALIZEDSTRING(@"readContactWasDeny")];
            }
                break;
            case kABAuthorizationStatusAuthorized:
            {
                bNext = YES;
            }
                break;
            default:
                break;
        }
        
        if (bNext) {
            ABPeoplePickerNavigationController *pNC = [[ABPeoplePickerNavigationController alloc] init];
            pNC.peoplePickerDelegate = self;
            [_baseVC presentViewController:pNC animated:YES completion:nil];
        }
    }
}



#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    [self setContactPhone:peoplePicker didSelectPerson:person identifier:0];
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
{
    [self setContactPhone:peoplePicker didSelectPerson:person identifier:0];
}

- (void)setContactPhone:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,(ABMultiValueIdentifier)0);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    [self selectedPhone:phoneNO];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark - CNContactPickerDelegate
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    DLog(@"didSelectContact");
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    DLog(@"didSelectContactProperty");
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts {
    DLog(@"didSelectContacts");
    if (!contacts || [contacts count] == 0) {
        return;
    }
    
    __block NSMutableArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = [[NSMutableArray alloc] init];
    [contacts enumerateObjectsUsingBlock:^(CNContact * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<CNLabeledValue<CNPhoneNumber*>*> *objPhoneNumbers = obj.phoneNumbers;
        [phoneNumbers addObjectsFromArray:objPhoneNumbers];
    }];
   
    [self showContactsNumbers:phoneNumbers];
}

- (void)showContactsNumbers:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)phoneNumbers {
    if (!phoneNumbers || [phoneNumbers count] == 0) {
        return;
    }
    
    if (phoneNumbers.count == 1) {
        CNLabeledValue<CNPhoneNumber*> *labeledValue = phoneNumbers[0];
        
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        [self selectedPhone:phoneValue];
        return;
    }
    
    NSMutableArray *phoneArray = [NSMutableArray arrayWithCapacity:phoneNumbers.count];
    [phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue<CNPhoneNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CNPhoneNumber *phoneNumer = obj.value;
        NSString *phoneValue = phoneNumer.stringValue;
        [phoneArray addObject:phoneValue];
    }];
    
    [self showMuitiplyPhone:phoneArray];
}

- (void)showMuitiplyPhone:(NSMutableArray *)phoneArray {
    
    ELockWeakSelf();
    HZBitPopupView *hzBitPopupView = [[HZBitPopupView alloc] initHZBitPopupView:phoneArray];
    hzBitPopupView.block = ^(NSInteger index) {
        NSString *num = phoneArray[index];
        [weakSelf selectedPhone:num];
    };
    [hzBitPopupView show];
}

- (void)selectedPhone:(NSString *)phoneValue {
    if (!phoneValue || [@"" isEqualToString:phoneValue]) {
        DLog(@"phoneValue is valid!");
        return;
    }

    NSString *numbers = [NSString stringWithString:phoneValue];
    if ([numbers hasPrefix:kCountryPrefix]) {
        numbers = [numbers substringFromIndex:kCountryPrefix.length];
    }
    
    numbers = [numbers stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    numbers = [numbers stringByReplacingOccurrencesOfString:@" " withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSData *data = [numbers dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *stringM = [@"" mutableCopy];
    
    //去除 1 - 9以外的任何数
    for (NSUInteger i = 0; i < [data length]; i++) {
        if (bytes[i] >= 0x30 && bytes[i] <= 0x39) {
            [stringM appendFormat:@"%c", bytes[i]];
        }
    }
    DLog(@" stringM %@ ", stringM);

    if (_delegate && [_delegate respondsToSelector:@selector(selectedContact:)]) {
        [_delegate selectedContact:stringM];
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties {
    DLog(@"didSelectContactProperties");
}

@end
