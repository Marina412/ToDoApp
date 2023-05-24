//
//  AddViewController.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "AddViewController.h"
#import "CustomTask.h"
#import "TODOViewController.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *scontrol;
@property (weak, nonatomic) IBOutlet UITextField *taskTitle;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePic;
@property (weak, nonatomic) IBOutlet UITextField *taskDesc;
- (IBAction)addTask:(id)sender;


@property NSUserDefaults *dev;
@property NSData *dataRepresentingSavedArray;
@property NSUInteger itemCount;
@property NSMutableArray *dataArray;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTask:(id)sender {
    if( _taskTitle)
        
        if(_taskTitle.text ==nil||_taskTitle.text.length==0)
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"ERROR" message:@"Check your data pleas !!!"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm=[ UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            
            [self saveArrayOfCustomObjectsToUserDefaults];
            [self.navigationController  popViewControllerAnimated:YES ];
            
            
        }
        
        
}- (NSMutableArray *)getArrayOfCustomObjectsToUserDefaults{
    _dev = [NSUserDefaults standardUserDefaults];
   _dataRepresentingSavedArray = [_dev objectForKey:@"savedArray"];
   _dataArray = nil;
   
   if (_dataRepresentingSavedArray != nil)
   {
   NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:_dataRepresentingSavedArray];
       if (savedArray != nil){
           _dataArray = [[NSMutableArray alloc] initWithArray:savedArray];
       }
       else{
           _dataArray = [[NSMutableArray alloc] init];
       }
           
       }
      return _dataArray;
}
-(void)saveArrayOfCustomObjectsToUserDefaults
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"EEEE,MMMM,yyyy-MM-dd";//,HH:mm'at'";
    NSDate *currentDate = self.datePic.date;
    NSString * dateStr = [[dateFormatter stringFromDate:currentDate] capitalizedString];
    
 CustomTask *obj1 = [[CustomTask alloc] init];
    obj1.title = _taskTitle.text;
    obj1.descripition = _taskDesc.text;
    obj1.priority = _scontrol.selectedSegmentIndex;
    obj1.date=dateStr;
    obj1.state=2;
 //get add save
    NSMutableArray *objectArray = [self getArrayOfCustomObjectsToUserDefaults];
    printf("\n mmmmmmbefor %lu tttt %s",(unsigned long)[self getArrayOfCustomObjectsToUserDefaults].count,[objectArray.description UTF8String]);
    if (objectArray != nil){
        [objectArray addObject:obj1];
        printf("\n mmmmmmbefor  if %lu tttt %s",(unsigned long)[self getArrayOfCustomObjectsToUserDefaults].count,[objectArray.description UTF8String]);
    }
    else{
        objectArray = [[NSMutableArray alloc] init];
        printf("\n mmmmmmbefor  else %lu tttt %s",(unsigned long)[self getArrayOfCustomObjectsToUserDefaults].count,[objectArray.description UTF8String]);
        [objectArray addObject:obj1];
    }
    
    printf("\n mmmmmmafter %lu",objectArray.count);
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArray] forKey:@"savedArray"];
 [defaults synchronize];
    
    printf("\nsavedd\n");
}








@end
