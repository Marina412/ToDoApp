//
//  InProgViewController.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "InProgViewController.h"
#import "InProgDetailsViewController.h"
@interface InProgViewController ()
- (IBAction)filter:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableToDo;

@property NSUserDefaults *dev;
@property NSData *dataRepresentingSavedArray;
@property NSUInteger itemCount,sectionCount;
@property NSMutableArray *dataArray,*inProArray,*lowDataArray,*hightDataArray,*medDataArray;
@property Boolean isFilterPress;
-(void)filterdData;
@end

@implementation InProgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        _itemCount=[self getArrayOfCustomObjectsToUserDefaults].count;
        _sectionCount=1;
        _isFilterPress=NO;
        [self.tableToDo reloadData ];
    }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

        return _sectionCount;
    }
- (void)viewWillAppear:(BOOL)animated{
    _itemCount=[self getArrayOfCustomObjectsToUserDefaults].count;
    [self.tableToDo reloadData];

    if(_isFilterPress){
        self.filterdData;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if(_sectionCount==3){
                switch (section) {
                    case 0:
                        return _hightDataArray.count;
                        break;
                    case 1:
                        return _medDataArray.count;
                        break;
                    case 2:
                        return _lowDataArray.count;
                        break;
                    default:
                        break;
                }
            }
            
        return _itemCount;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     InProgDetailsViewController  *sc=[self.storyboard instantiateViewControllerWithIdentifier:@"inprosc"];
    CustomTask *ct=[CustomTask new];
    if(_isFilterPress){
        switch (indexPath.section) {
                    case 0:
                      ct=(self.hightDataArray)[indexPath.row];
                
                        break;
                    case 1:
                ct=(self.medDataArray)[indexPath.row];
                        break;
                    case 2:
                ct=(self.lowDataArray)[indexPath.row];
                        break;
                    default:
                        break;
                }
    }
    else{
        ct=(self.inProArray)[indexPath.row];
    }
    
   // cp=(self.inProArray)[indexPath.row];
    for(int i=0;i<_dataArray.count;i++){
        CustomTask *c=[CustomTask new];
        c=_dataArray[i];
        if(c.title==ct.title){
            sc.taskIndex=i;
            printf("\n index %d",i);
        }
    }
    sc.task=ct;
    [self.navigationController pushViewController:sc animated:YES];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_sectionCount==3){
    switch (section) {
               case 0:
                   return @"High Priority";
                   break;
               case 1 :
                   return @"Medium Priority";
                   break;;
               case 2:
                   return @"Low Priority";
                   break;
               default:
                   break;
           }
       }else{
           return @"All Tasks";
       }
       return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltodo" forIndexPath:indexPath];
    CustomTask *ct=[[CustomTask alloc]init];
    if(_isFilterPress){
        switch (indexPath.section) {
                    case 0:
                      ct=(self.hightDataArray)[indexPath.row];
                
                        break;
                    case 1:
                ct=(self.medDataArray)[indexPath.row];
                        break;
                    case 2:
                ct=(self.lowDataArray)[indexPath.row];
                        break;
                    default:
                        break;
                }
    }
    else{
        ct=(self.inProArray)[indexPath.row];
    }
    
    cell.textLabel.text=ct.title;
    if(ct.priority==0){
        cell.imageView.image=[UIImage imageNamed:@"0"];
    }
    else if(ct.priority==1){
            cell.imageView.image=[UIImage imageNamed:@"1"];
        }
    else if(ct.priority==2){
                cell.imageView.image=[UIImage imageNamed:@"2"];
            }
   
    
    return cell;
}


- (NSMutableArray *)getArrayOfCustomObjectsToUserDefaults{
        _dev = [NSUserDefaults standardUserDefaults];
        _dataRepresentingSavedArray = [_dev objectForKey:@"savedArray"];
        _dataArray = nil;
        _inProArray=[NSMutableArray new];
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
    for(int i=0;i<_dataArray.count;i++){
        CustomTask *c=[CustomTask new];
        c=_dataArray[i];
        if(c.state==1){
            [_inProArray addObject:c];
        }
    }
        return _inProArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)filter:(id)sender {
    _isFilterPress=!_isFilterPress;
    
    if(_isFilterPress)
    {
        self.filterdData;
        
    }
    else{
        _sectionCount=1;
        [_tableToDo reloadData];
        
    }
   
}

-(void)filterdData{
    _sectionCount=3;
    
    _medDataArray=[NSMutableArray new];
    _lowDataArray=[NSMutableArray new];
    _hightDataArray=[NSMutableArray new];

    for(int i=0;i< _inProArray.count;i++){
        CustomTask *ta=_inProArray[i];
        printf("\n title %s  , pir %lu , desc %s",[ta.title UTF8String],ta.priority,[ta.descripition UTF8String]);
        if(ta.priority==0)
        {
            [_hightDataArray addObject:ta];
        }
        else if(ta.priority==1)
        {
            [_medDataArray addObject:ta];
        }
        else{
            [_lowDataArray addObject:ta];
        }
    }
    [_tableToDo reloadData];
}

@end
