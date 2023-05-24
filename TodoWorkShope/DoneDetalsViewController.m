//
//  DoneDetalsViewController.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "DoneDetalsViewController.h"

@interface DoneDetalsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTask;
@property (weak, nonatomic) IBOutlet UITextField *descTask;
@property (weak, nonatomic) IBOutlet UILabel *taskDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskPriority;

- (IBAction)deleteTask:(id)sender;



@property NSUserDefaults *dev;
@property NSData *dataRepresentingSavedArray;
@property NSUInteger itemCount;
@property NSMutableArray *dataArray;

@end

@implementation DoneDetalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleTask.text=_task.title;
    self.descTask.text=_task.descripition;
    self.taskPriority.selectedSegmentIndex=_task.priority;
   // self.taskState.selected=_task.state;
    self.taskDate.text=_task.date;
    // Do any additional setup after loading the view.
    self.taskPriority.userInteractionEnabled=NO;
    self.titleTask.userInteractionEnabled=NO;
    self.descTask.userInteractionEnabled=NO;
    
}




- (NSMutableArray *)getArrayOfCustomObjectsToUserDefaults{//}:(NSString *) saveKey{
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

-(void)saveDeletedArrayOfCustomObjectsToUserDefaults
{

//get delete save
    NSMutableArray *objectArraySave = [NSMutableArray new];
    objectArraySave=[self getArrayOfCustomObjectsToUserDefaults];
    [objectArraySave  removeObjectAtIndex:self.taskIndex];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArraySave] forKey:@"savedArray"];
    [defaults synchronize];


    printf("\nsavedd\n");
}


- (IBAction)deleteTask:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"DELETION" message:@"Do you whant to delete this task ?"
                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[ UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        [self saveDeletedArrayOfCustomObjectsToUserDefaults];
        
        [self.navigationController  popViewControllerAnimated:YES ];
        
    }];
    UIAlertAction *cancel=[ UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:confirm];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

