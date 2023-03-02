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

    if (self.isDetail) {
        self.nameTextField.text = self.eventInfo;
        self.datePicker.date = self.eventDate;
    }
    else {
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
}

- (void) save {
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

- (void) handleEndEditing {
    [self.view endEditing:YES];
}

- (void) datePickerValueChanged {
    self.eventDate = self.datePicker.date;
    NSLog(@"date Picker %@", self.eventDate);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual: self.nameTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)saveButton:(UIButton *)sender {
}

- (IBAction)datePicker:(UIDatePicker *)sender {
}

- (IBAction)nameTextField:(UITextField *)sender {
}

@end
