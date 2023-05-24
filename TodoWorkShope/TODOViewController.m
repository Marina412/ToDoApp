//
//  TODOViewController.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "TODOViewController.h"
#import "DetailsViewController.h"
#import "CustomTask.h"
#import "AddViewController.h"
@interface TODOViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *search;
- (IBAction)addTaske:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableTodo;
@property NSUserDefaults *dev;
@property NSData *dataRepresentingSavedArray;
@property NSUInteger itemCount;
@property NSMutableArray *dataArray,*todoArray;

@end

@implementation TODOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemCount=[self getArrayOfCustomObjectsToUserDefaults].count;
    [self.tableTodo reloadData ];
}
- (NSMutableArray *)getArrayOfCustomObjectsToUserDefaults{
     _dev = [NSUserDefaults standardUserDefaults];
    _dataRepresentingSavedArray = [_dev objectForKey:@"savedArray"];
    _dataArray = nil;
    _todoArray=[NSMutableArray new];
    
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
            if(c.state==2){
                [_todoArray addObject:c];
                
            }
        }
    
    
    return _todoArray;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        _dataArray = [self getArrayOfCustomObjectsToUserDefaults];
        _itemCount=_dataArray.count;
        [_tableTodo reloadData];
    }
    else{
        NSString *text = [searchText lowercaseString];
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            BOOL match = [((CustomTask*)evaluatedObject).title containsString:text];
            return match;
        }];
        
        _dataArray = (NSMutableArray<CustomTask*>*)[
            _dataArray filteredArrayUsingPredicate:predicate];
        _itemCount=_dataArray.count;
        [_tableTodo reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _itemCount;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DetailsViewController  *sc=[self.storyboard instantiateViewControllerWithIdentifier:@"desc"];
    CustomTask *cp=(self.todoArray)[indexPath.row];
    for(int i=0;i<_dataArray.count;i++){
        CustomTask *c=[CustomTask new];
        c=_dataArray[i];
        if(c.title==cp.title){
            sc.taskIndex=i;
        }
    }
    //sc.taskIndex=indexPath;
    sc.task=cp;

    
    [self.navigationController pushViewController:sc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltodo" forIndexPath:indexPath];
    CustomTask *ct=(self.todoArray)[indexPath.row];
    
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    _itemCount=[self getArrayOfCustomObjectsToUserDefaults].count;
    [self.tableTodo reloadData ];
}

- (IBAction)addTaske:(id)sender {
    AddViewController *addsc=[self.storyboard instantiateViewControllerWithIdentifier:@"addsc"];
         [self.navigationController pushViewController:addsc animated:YES];
    printf("\nclick add task\n");
}
@end
