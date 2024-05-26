/*
	File: scripts/scene_title
	Author: Astrofra
*/

	Include("scripts/base_scene.nut")

/*!
	@short	TitleScene
	@author	Astrofra
*/
class	SceneTitle	extends	BaseScene
{
	title_ui				=	0

	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
		base.OnUpdate(scene)
		title_ui.UpdateCursor()
	}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
		base.OnSetup(scene)
		title_ui = BaseUI(SceneGetUI(scene))
	}

	constructor()
	{
		base.constructor()
	}
}
