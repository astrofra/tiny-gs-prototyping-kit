/*
	File: scripts/test_scene_0.nut
	Author: Astrofra
*/

/*!
	@short	TestScene0
	@author	Astrofra
*/
class	TestScene0
{
	_timer	=	0

	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
		if ((g_clock - _timer)  > SecToTick(Sec(5.0)))
			ProjectGetScriptInstance(g_project).ProjectGotoScene("scenes/test_scene_1.nms")
	}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
		_timer =	g_clock
	}
}
