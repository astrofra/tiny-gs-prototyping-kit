/*
	File: scripts/level_handler.nut
	Author: Astrofra
*/

/*!
	@short	LevelHandler
	@author	Astrofra
*/
class	LevelHandler	extends	BaseScene
{

	camera_handler		=	0
	player_item			=	0
	base_ui				=	0
	
	constructor()
	{
		base.constructor()
	}

	function	OnUpdate(scene)
	{
		base.OnUpdate(scene)
		camera_handler.FollowPlayerPosition(ItemGetPosition(player_item))
		base_ui.UpdateCursor()
	}

	function	OnSetup(scene)
	{
		base.OnSetup(scene)
		base_ui = BaseUI(SceneGetUI(scene))
	}

	function	OnSetupDone(scene)
	{
		//base.OnSetupDone(scene)
		camera_handler = CameraHandler(scene)
		player_item = SceneFindItem(scene, "player")
	}
}
