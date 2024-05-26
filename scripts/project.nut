/*
*/

	Include("scripts/base_project.nut")
	
//
class	ProjectHandler	extends	BaseProjectHandler
{

	function	OnUpdate(project)
	{
		base.OnUpdate(project)
	}

	function	OnSetup(project)
	{
		base.OnSetup(project)
	}
	
	constructor()
	{
		base.constructor()
		entry_point			=	"scenes/test_scene_character.nms"
	}
}
