/*
	File: scripts/base_player_platformer.nut
	Author: Astrofra
*/

/*!
	@short	BasePlayerPlatformer
	@author	Astrofra
*/

class	BasePlayerPlatformer	extends	PlayerPhysic2D
{
	max_speed			=	Mtrs(2.0)
	pad_is_enabled		=	false
	pad_device			=	0
	pad					=	0
	strength			=	100.0

	constructor()
	{
		base.constructor()

		if (pad_is_enabled)
			pad_device = GetInputDevice("xinput0")
		else
			pad_device = GetKeyboardDevice()

		pad = {	d_vector = Vector(0,0,0)
			}
	
	}

	//------------------------
	function	OnUpdate(item)
	//------------------------
	{
		if (pad_is_enabled)
		{
			pad.d_vector.x = DeviceInputValue(pad_device, DeviceAxisX)
			pad.d_vector.y = DeviceInputValue(pad_device, DeviceAxisY)
		}
		else
		{
			pad.d_vector.x = 0.0
			pad.d_vector.y = 0.0

			if (DeviceIsKeyDown(pad_device, KeyLeftArrow))
				pad.d_vector.x = -1.0
			else
			if (DeviceIsKeyDown(pad_device, KeyRightArrow))
				pad.d_vector.x = 1.0
			 
			if (DeviceIsKeyDown(pad_device, KeyUpArrow))
				pad.d_vector.y = -1.0
			else
			if (DeviceIsKeyDown(pad_device, KeyDownArrow))
				pad.d_vector.y = 1.0
		}
		//		pad.d_vector.Print("pad.d_vector")		
	}

	//--------------------------------
	function	OnPhysicStep(item, dt)
	//--------------------------------
	{
		base.OnPhysicStep(item, dt)
		ItemApplyLinearForce(item, pad.d_vector.Scale(strength * ItemGetMass(item) * low_dt_compensation))
	}
}