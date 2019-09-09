//
//  LeaderBoardVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 8/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "LeaderBoardVC.h"

@implementation LeaderBoardVC
@synthesize tableView, players;

- (void)viewDidLoad {
    [super viewDidLoad];
    players = [[NSMutableArray alloc] init];
    //setup tableview
    tableView.delegate = self;
    tableView.dataSource = self;
    //cell cannot be clickeds
    [tableView setAllowsSelection:NO];
    //register custom cell
    [tableView registerNib:[UINib nibWithNibName:LEADERBOARD_CELL_ID bundle:nil] forCellReuseIdentifier:LEADERBOARD_CELL_ID];
    //change navigation bar title
    [[self navigationItem] setTitle:@"LEADERBOARD"];
    //get data from firestore/db
    [self prepareData];
}

//get users from firestore/db and save to players array
- (void)prepareData {
    //get users from firestore ordered descending by score
    [[[[AppHelper db] collectionWithPath:FIRESTORE_USERS] queryOrderedByField:@"score" descending:YES] getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if(error) {
            [AppHelper presentSimpleAlertWithTitle:@"Error" Message:[error localizedDescription] adnViewController:self];
            return;
        }
        for(FIRDocumentSnapshot *document in [snapshot documents]) {
            //create player array with name and score
            NSArray *player = [[NSArray alloc] initWithObjects:document[@"fullName"], document[@"score"], nil];
            //add player to players array
            [[self players] addObject:player];
        }
        //reload tableview data
        [[self tableView] reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaderBoardCell *cell = (LeaderBoardCell *)[tableView dequeueReusableCellWithIdentifier:LEADERBOARD_CELL_ID forIndexPath:indexPath];
    if(cell) {
        NSArray *player = [[self players] objectAtIndex:[indexPath row]];
        [[cell playerName] setText:[NSString stringWithFormat:@"%@", [player objectAtIndex:0]]];
        [[cell playerScore] setText:[NSString stringWithFormat:@"%@", [player objectAtIndex:1]]];
        return cell;
    }
    
    return nil;
}

@end
