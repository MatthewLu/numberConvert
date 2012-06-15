//
//  ViewController.m
//  numberConvert
//
//  Created by Matthew Lu on 10/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize inputfield;
@synthesize convertBtn;
@synthesize outputfield;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self english_num:0];
       [self english_num:9];
       [self english_num:10];
       [self english_num:11];
       [self english_num:17];
       [self english_num:32];
       [self english_num:88];
       [self english_num:99];
       [self english_num:100];
       [self english_num:101];
       [self english_num:234];
       [self english_num:3211];
       [self english_num:999999];
       [self english_num:10000000000000];
}

- (void)viewDidUnload
{
    [self setInputfield:nil];
    [self setConvertBtn:nil];
    [self setOutputfield:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)Convert:(id)sender {
    
    int inputNumber = [inputfield.text intValue];
    
    
    
    outputfield.text = [self english_num:inputNumber];
    
}



-(NSString*) english_num:(int)inputNumber
{
    
    if(inputNumber<0)
    {
        return [NSString stringWithFormat:@"Plasee enter a number more then 0"];
    }
    
    if(inputNumber==0)
    {
        return [NSString stringWithFormat:@"Zero"];
    }
    
    NSString *num_string = @"";
    
    NSArray *one_place =[[NSArray alloc] initWithObjects:@"one",@"two",@"three",
                         @"four",@"five",@"six",
                         @"seven",@"eight",@"nine",nil];
    
    NSArray *ten_place =[[NSArray alloc] initWithObjects:@"ten",@"twenty",@"thirty",
                         @"forty",@"fifty",@"sixty",
                         @"seventy",@"eighty",@"ninety",nil];
    
    NSArray *teenagers =[[NSArray alloc] initWithObjects:@"eleven",@"twelve",@"thirteen",
                         @"fourteen",@"fifteen",@"sixteen",
                         @"seventeen",@"eightenn",@"nineteen",nil];
    
    NSMutableArray *zillionIndex = [NSMutableArray arrayWithObjects:@"2",@"3",@"6",@"9", nil];
    NSMutableDictionary *zillions = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"hundred",@"2",@"thousand",@"3", @"million",@"6",@"billion",@"9", nil];
    
    
    
    
    // left is how much of the number we still have left to write out
    //  write is the part we are writing out right now
    int left = inputNumber;
    int write = 0;

    while ([zillionIndex count]>0) {
        
        NSString *zil_name = [zillions objectForKey:zillionIndex.lastObject];
        int zil_base = pow(10, [zillionIndex.lastObject intValue]);
        [zillionIndex removeLastObject];
        int write = left/zil_base;
        left = left -write*zil_base;
        
        if(write>0)
        {
            NSString *prefix = [self english_num:write];
           num_string =[[[num_string stringByAppendingFormat:prefix] stringByAppendingFormat:@" "] stringByAppendingFormat:zil_name];
        
          if(left >0)
          {
              num_string = [num_string stringByAppendingFormat:@" "];
          }
            
        
        }
        
        
    }
    
    
    
    write = left /10; //how many tens left
    left= left -write *10; // subtract off those tens
    
    
    if(write > 0)
    {
        if((write==1) && (left >0))
        {
        //Since we can't write 'tenty-two' instead of ‘twelve’, we have to make a special exception
        // for these
            num_string = [num_string stringByAppendingFormat:[teenagers objectAtIndex:left-1]] ;
        // the '-1' is because teenagers[3] is 'fourteen', not 'thirteen'
        // Since we took care of the digit int he ones place already, we have nothing to write
            left = 0 ;
        }
        else {
            num_string = [num_string stringByAppendingFormat:[ten_place objectAtIndex:write-1]];
            
            // the '-1' is because tens_place[3] is 'forty', not 'thirty'
        }
        
        if(left>0)
        {
            //So we dont write 'sixtyfour'
            num_string = [num_string stringByAppendingFormat:@"-"];
        }
    }
    
    
    
    write = left; //how many ones left to write out
    left = 0; // subtract off those ones
    
    if(write> 0)
    {

    
        num_string = [num_string stringByAppendingFormat:[one_place objectAtIndex:write-1]];
    }
    
    
    NSLog(@"%@",num_string);
    return num_string;
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
