function Get-DaySuffix
{
	Param(
		[System.DateTime]$date_input
	)
	switch ($date_input.Day)
	{
		{$_ -in 1,21,31} {$suffix = 'st'}
		{$_ -in 2,22} {$suffix = 'nd'}
		{$_ -in 3,23} {$suffix = 'rd'}
		Default {$suffix = 'th'}
	}

return $suffix
}
$next_monday = (Get-Date).AddDays(1 - (Get-Date).DayOfWeek)  # [datetime] Get the date of the next monday 
$clipboard = "" # [string] initialize clipboard contents, to be filled in with dates

for($i = 0; $i -lt 5 ; $i++){ # Add to clipboard each day for next week
	$current_date = $next_monday.AddDays($i)  
	$current_suffix = Get-DaySuffix -date_input ($current_date) # [string] obtain suffix for specific date (ex. th, rd, etc)

	if(($current_date.DayOfWeek -eq 2) -or ($current_date.DayOfWeek -eq 4)){ # Check if Tuesday or Thursday (times changed due to morning meeting)
		$clipboard += "$($current_date | Get-Date -Format "dddd, MMMM d")$current_suffix, 11am to 5pm`n" # Availability times for Tuesday and Thursday
	}else{
	$clipboard += "$($current_date | Get-Date -Format "dddd, MMMM d")$current_suffix, 10am to 5pm`n" # Availability times for any other day
	}
}
Set-Clipboard $clipboard
