//
//  DetailsViewController.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTask;
@property (weak, nonatomic) IBOutlet UITextField *descTask;

@property (weak, nonatomic) IBOutlet UILabel *taskDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskState;

- (IBAction)editTask:(id)sender;
- (IBAction)deleteTask:(id)sender;



@property NSUserDefaults *dev;
@property NSData *dataRepresentingSavedArray;
@property NSUInteger itemCount;
@property NSMutableArray *dataArray;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleTask.text=_task.title;
    self.descTask.text=_task.descripition;
    self.taskPriority.selectedSegmentIndex=_task.priority;
    self.taskState.selectedSegmentIndex=_task.state;
    self.taskDate.text=_task.date;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)editTask:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"EDITING" message:@"Do you whant to edit this task ?"
                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[ UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        [self saveUpdatedArrayOfCustomObjectsToUserDefaults];
        
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
//    NSString *saveKey=[NSString new];
//    if (_taskState.selectedSegmentIndex ==1){
//        saveKey=@"inSavedArray";
//    }
//    else if (_taskState.selectedSegmentIndex ==2){
//        saveKey=@"doneSavedArray";
//    }
//    else{
//        saveKey=@"savedArray";
//    }
//get delete save
    NSMutableArray *objectArraySave = [NSMutableArray new];
    objectArraySave=[self getArrayOfCustomObjectsToUserDefaults];
    [objectArraySave  removeObjectAtIndex:self.taskIndex];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArraySave] forKey:@"savedArray"];
    [defaults synchronize];


    printf("\nsavedd\n");
}


-(void)saveUpdatedArrayOfCustomObjectsToUserDefaults
{
    
    CustomTask *obj1 = [[CustomTask alloc] init];
    //NSString *saveKey=[NSString new];
    obj1.title = _titleTask.text;
    obj1.descripition = _descTask.text;
    obj1.priority = _taskPriority.selectedSegmentIndex;
    obj1.date=_taskDate.text;
    obj1.state=_taskState.selectedSegmentIndex;
//get delete save
    NSMutableArray *objectArraySave = [NSMutableArray new];
    objectArraySave=  [self getArrayOfCustomObjectsToUserDefaults];
    printf("\n %lu  ppppppppp\n",(unsigned long)objectArraySave.count);
    
   [objectArraySave  replaceObjectAtIndex:self.taskIndex withObject:obj1];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objectArraySave] forKey:@"savedArray"];
    [defaults synchronize];

    printf("\nsavedd\n");
}

@end
