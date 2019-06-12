

 
#define SQDefaults [NSUserDefaults standardUserDefaults] 
#define SQAutoKey @"sq_auto_key"
// #define SQFile(path) @"/Library/PreferenceLoader/Preferences/SQWeChat/" #path
#define SQFile(path) @"/Library/Caches/SQWeChat/" #path

%hook FindFriendEntryViewController

- (long long)numberOfSectionsInTableView:(id)tableView {
	return %orig + 1;
}

- (long long)tableView:(id)tableView numberOfRowsInSection:(long long)section {
	if  (section == [self numberOfSectionsInTableView: tableView] - 1) {
		return 2;
	}
	return %orig;
}

%new
- (void)mj_autoChange: (UISwitch *)sender {
	[MJDefaults setBool: sender.isOn forKey: MJAutoKey];
	[MJDefaults synchronize];
}

- (id)tableView:(id)tableView cellForRowAtIndexPath:(id)indexpath {
	if  ([indexpath section] != [self numberOfSectionsInTableView: tableView] - 1) {
		return %orig;
	}

	NSString * cellId = [indexpath row] == 0 ? @"autoCellId" : @"exitCellId";
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellId];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
		cell.backgroundColor = [UIColor whiteColor];
		cell.imageView.image = [UIImage imageWithContentsOfFile:MJFile(avatar.jpg)];
	}
	if ([indexpath row] == 0) {
		cell.textLabel.text = @"自动抢红包";
		UISwitch * switchView = [[UISwitch alloc]init];
		switchView.on = [MJDefaults boolForKey:MJAutoKey];    
		[switchView addTarget:self action:@selector(mj_autoChange:) forControlEvents:UIControlEventValueChanged];
		cell.accessoryView = switchView;
	} else if ([indexpath row] == 1) {
		cell.textLabel.text = @"退出微信";
	}
    return cell;
} 

- (double)tableView:(id)tableView heightForRowAtIndexPath:(id)indexpath {
	if  ([indexpath section] != [self numberOfSectionsInTableView: tableView] - 1) {
		return %orig;
	}
	return 44;
}

- (void)tableView:(id)tableView didSelectRowAtIndexPath:(id)indexpath {
	if  ([indexpath section] != [self numberOfSectionsInTableView: tableView] - 1) {
		%orig;
		return;
	}
	[tableView deselectRowAtIndexPath:indexpath animated:YES];

	if ([indexpath row] == 1)
	{	
		abort();
	}
}


%end

