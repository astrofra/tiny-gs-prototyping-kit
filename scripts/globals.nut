	//	Globals.nut

	function	IsTouchPlatform()
	{
		if (g_platform == "Android")
			return true
		else
			return false
	}

	g_device				<-	GetKeyboardDevice()
	g_ui_cursor				<-	UICreateCursor(0)


	g_gravity				<-	Vector(0.0, -9.8, 0.0)
	g_reversed_controls		<-	false
	g_time_key_order		<-	["hour", "minute", "second", "ms"]

	