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
    NSLog(@"Save");
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
