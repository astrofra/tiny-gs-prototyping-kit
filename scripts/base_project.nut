/*
*/

	Include("scriptlib/nad.nut")
	Include("scripts/globals.nut")
	Include("scripts/utils.nut")
	Include("scripts/locale.nut")
	Include("scripts/ace_deleter.nut")
	Include("scripts/particle_emitter.nut")
	Include("scripts/camera_handler.nut")
	Include("scripts/base_scene.nut")
	Include("scripts/base_player_physic_2D.nut")
	Include("scripts/ui.nut")	

//
class	BaseProjectHandler
{
	//	Public
	entry_point			=	"scenes/title.nms"
	//	Private
	scene				=	0
	scene_filename		=	""
	prev_scene_filename	=	""
	
	dispatch			=	0
	
	function	ProjectGotoScene(_fname)
	{
		scene_filename = _fname
	}

	function	OnUpdate(project)
	{
		dispatch(project, scene)
	}
	
	function	MainUpdate(project, scene)
	{
		if (scene_filename != prev_scene_filename)
		{
			dispatch = LeaveCurrentScene
			if (scene != 0)
				UISetCommandList(SceneGetUI(ProjectSceneGetInstance(scene)), "globalfade 0.5, 1;")
		}
	}
	
	function	LeaveCurrentScene(project, scene)
	{
		if (scene == 0)
		{
			ProjectLoadScene(project, scene_filename)
			prev_scene_filename = scene_filename
			dispatch = MainUpdate
		}
		else
		{
			if	(UIIsCommandListDone(SceneGetUI(ProjectSceneGetInstance(scene))))
			{
				ProjectUnloadScene(project, scene)			
				ProjectLoadScene(project, scene_filename)
				prev_scene_filename = scene_filename
				dispatch = MainUpdate
			}
		}
	}

	function	ProjectLoadScene(project, scene_filename)
	{
		if	(FileExists(scene_filename))
		{
			print("ProjectHandler::LeaveCurrentScene() Loading scene '" + scene_filename + "'.")
			scene = ProjectInstantiateScene(project, scene_filename)
			ProjectAddLayer(project, scene, 0.5)
		}
		else
			error("ProjectHandler::LeaveCurrentScene() Cannot find scene '" + scene_filename + "'.")

		return	scene
	}

	function	OnSetup(project)
	{
		print("ProjectHandler::OnSetup()")
		ProjectGotoScene(entry_point)
	}
	
	constructor()
	{
		print("ProjectHandler::constructor()")
		dispatch = MainUpdate
	}
}
