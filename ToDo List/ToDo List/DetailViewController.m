//
//  ViewController.m
//  ToDo List
//
//  Created by Алексей Шевченко on 02.03.2023.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.saveButton.userInteractionEnabled = NO;
    self.datePicker.minimumDate = [NSDate date];
    
    [self.datePicker
     addTarget:self
     action:@selector(datePickerValueChanged)
     forControlEvents:UIControlEventValueChanged];
    
    [self.saveButton
     addTarget:self
     action:@selector(save)
     forControlEvents: UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc]
                                          initWithTarget: self
                                          action: @selector(handleEndEditing)];
                                          
    [self.view addGestureRecognizer:handleTap];
}

- (void) save {
    if (self.eventDate) {
        if([self.eventDate compare:[NSDate date]] == NSOrderedSame) {
            [self showAlertWithMessage:@"Date of ivent can't be the same of currently"];
        }
        
        else if ([self.eventDate compare:[NSDate date]] == NSOrderedAscending) {
            [self showAlertWithMessage:@"Date of ivent can't be rarely of currently"];
        }
        
        else {
            [self setNotification];
        }
    }
    else {
        [self showAlertWithMessage:@"For save ivent changed date to some late"];
    }
}

- (void) handleEndEditing {
    if ([self.nameTextField.text length] != 0) {
        [self.view endEditing:YES];;
        self.saveButton.userInteractionEnabled = YES;
    }
    else {
        [self showAlertWithMessage:@"For save ivent input text on text field"];
    }
}

- (void) datePickerValueChanged {
    self.eventDate = self.datePicker.date;
    NSLog(@"date Picker %@", self.eventDate);
}

- (void) setNotification {
    NSString * eventInfo = self.nameTextField.text;
    
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString * eventDate = [formater stringFromDate: self.eventDate];
    
    NSDictionary * dateDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               eventInfo, @"eventInfo",
                               eventDate, @"eventDate", nil];
    
    // MARK: -- first deprecated in iOS 10.0
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.userInfo = dateDict;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification: notification];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual: self.nameTextField]) {
        
        if ([self.nameTextField.text length] != 0) {
            [self.nameTextField resignFirstResponder];
            self.saveButton.userInteractionEnabled = YES;
            return YES;
        }
        else {
            [self showAlertWithMessage:@"For save ivent input text on text field"];
        }
    }
    
    return NO;
}

- (void) showAlertWithMessage: (NSString *) message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Attention!"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
    [alert show];
}

@end
