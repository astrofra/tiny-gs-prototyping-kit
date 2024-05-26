/*
	File: scripts/scene.nut
	Author: Astrofra
*/

//------------------------------
function	GenericThreadWait(s)
//------------------------------
{
	local	_timeout

	_timeout = g_clock
				
	while ((g_clock - _timeout) < SecToTick(Sec(s)))
		suspend()
}

/*!
	@short	ThreadHandler
	@author	Astrofra
*/
//---------------
class	BaseScene
//---------------

{
	//	Public members
	current_scene			=	0
	low_dt_compensation		=	1.0
	
	//	Private members
	thread_list				=	0

	constructor()
	{
		thread_list			=	[]
		low_dt_compensation	=	1.0
	}

	//------------------------
	function	OnSetup(scene)
	//------------------------
	{
		current_scene = scene
	}

	//-------------------------
	function	OnUpdate(scene)
	//-------------------------
	{
		HandleThreadList()
		ComputeLowDeltaFrameCompensation()
	}
	
	//--------------------------------------------
	function	ComputeLowDeltaFrameCompensation()
	//--------------------------------------------
	{
		//	low_dt_compensation is a factor (btw 0.0 and 1.0)
		//	that you might need when apply forces, impulses & torques.
		low_dt_compensation = Clamp(1.0 / (60.0 * g_dt_frame), 0.0, 1.0)
	}

	//------------------------------------
	function	CreateThread(_thread_name)
	//------------------------------------
	{
		thread_list.append({name = _thread_name, handle = 0})
		local	_thread = thread_list[thread_list.len() - 1]
		_thread.handle = newthread(_thread.name)
		_thread.handle.call(current_scene)
	}

	//------------------------------------
	function	DestroyThread(_thread_name)
	//------------------------------------
	{
		foreach (idx, _thread in thread_list)
			if (_thread.name == _thread_name)
			{
				_thread.handle = 0
				thread_list.remove(idx)
			}
	}

	//---------------------------
	function	StartThreadList()
	//---------------------------
	{
		foreach (_thread in thread_list)
		{
			_thread.handle = newthread(_thread.name)
			_thread.handle.call(current_scene)
		}
	}
	
	//-------------------------------
	function	HandleThreadList()
	//-------------------------------
	{
		foreach (_thread in thread_list)
		{
			if (_thread.handle == 0)
				return

			if (_thread.handle.getstatus() == "suspended")
				_thread.handle.wakeup()
			else
			{
				foreach (idx, _thread_to_remove in thread_list)
					if (_thread_to_remove.handle == _thread.handle)
					{
						_thread_to_remove.handle = 0
						thread_list.remove(idx)
					}
			}
		}
	}

}
