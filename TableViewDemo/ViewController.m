//
//  ViewController.m
//  TableViewDemo
//
//  Created by Jihai on 2019/2/5.
//  Copyright © 2019年 Contextere. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self arraySetup];
    
    // init synthesizer
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    AVSpeechUtterance *utterance =[[AVSpeechUtterance alloc] initWithString:@"Hello"];
    [self.synthesizer speakUtterance:utterance];
}

-(void)arraySetup{
    dataArray = [NSMutableArray arrayWithArray:@[@"Hello,", @"My name is Janus.", @"I see you have two un-configured devices.", @"Do you want to configure them now?" ]];
}

#pragma mark - UITableView DataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    // cell.imageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    cell.textLabel.text = dataArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1 ];
    return cell;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

- (IBAction)refesh:(id)sender {
    [_table reloadData];
}

- (IBAction)removeTapped:(id)sender {
    [dataArray removeObjectAtIndex:0];
    [self.table reloadData];
}

- (IBAction)sendTapped:(id)sender {
    NSString *text = self.textField.text;
    [dataArray addObject:text];
    [self.table reloadData];
    
    AVSpeechUtterance *utterance =[[AVSpeechUtterance alloc] initWithString:text];
    [self.synthesizer speakUtterance:utterance];
    
}

- (IBAction)oneByOneTapped:(id)sender {
    NSMutableArray *dataContainer = [NSMutableArray arrayWithArray:dataArray];
    dataArray = [[NSMutableArray alloc] init];
    for(NSString* oneRow in dataContainer ){
        NSString *text = oneRow;
        [dataArray addObject:text];
        [self.table reloadData];
        // [NSThread sleepForTimeInterval:1.0f];
        
        // dispatch_async(dispatch_get_main_queue(), ^(void) {
        //    [self.table reloadData];
        // });
        
        // [self.table layoutIfNeeded];
        
        // dispatch_async(dispatch_get_main_queue(), ^{
        //     AVSpeechUtterance *utterance =[[AVSpeechUtterance alloc] initWithString:text];
        //     [self.synthesizer speakUtterance:utterance];
        // });
        
        AVSpeechUtterance *utterance =[[AVSpeechUtterance alloc] initWithString:text];
        [self.synthesizer speakUtterance:utterance];
        
    }
}


@end
