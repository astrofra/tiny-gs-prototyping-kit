/*
	File: scripts/base_player_physic_2D.nut
	Author: Astrofra
*/

/*!
	@short	PlayerPhysic2D
	@author	Astrofra
*/

class	PlayerPhysic2D	extends	BaseScene
{
	
	current_velocity			=	0
	max_speed					=	Mtrs(10.0)
	scene						=	0
	update_function				=	0

	//------------------------
	function	OnUpdate(item)
	//------------------------
	{
		base.OnUpdate(item)
		ItemWake(item)
	}

	//------------------------------
	function	OnPhysicStep(item, dt)
	//------------------------------
	{
		if (!dt)
		{
			print("Physic Step skipped")
			return
		}

		current_velocity = ItemGetLinearVelocity(item)

		AutoAlign(item)
		SpeedLimiter(item)
	}
	
	//--------------------------
	function	SpeedLimiter(item)
	//--------------------------
	{
		local	v_thrust = Vector(0,0,0)

		local	speed_limiter = Max(ItemGetLinearVelocity(item).Len() - max_speed, 0.0)
		if (speed_limiter > 0.0)
			ItemApplyLinearForce(item, ItemGetLinearVelocity(item).Scale(-speed_limiter * ItemGetMass(item) * low_dt_compensation))
//			ItemApplyLinearImpulse(item, ItemGetLinearVelocity(item).Scale(-speed_limiter * low_dt_compensation))

	}

	//-------------------------
	function	AutoAlign(item)
	//-------------------------
	{
		local	_align, _speed
		
		local	_rot_z = ItemGetRotation(item).z
		local	_ang_v_z = ItemGetAngularVelocity(item).z

		_align = Clamp(Abs(RadianToDegree(_rot_z)) / 180.0,0.0,1.0)
		_align *= 250.0

		_speed = ItemGetLinearVelocity(item).Len()
		_speed = RangeAdjust(_speed, 0.25, 0.5, 0.0, 1.0)
		_speed = Clamp(_speed, 0.0, 1.0)
		//_align *= _speed

		local	_torque_modulator
		_torque_modulator = _align * ItemGetMass(item) * low_dt_compensation
		print("_torque_modulator = " + _torque_modulator)
		_torque_modulator = Clamp(_torque_modulator, 0.0, 50.0)

		ItemApplyTorque(item, Vector(0,0,-_rot_z - _ang_v_z).Scale(_torque_modulator))
	}
	
	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	//-----------------------
	function	OnSetup(item)
	//-----------------------
	{
		print("PhysicPlayer2D::OnSetup()")
		
		base.OnSetup(item)
		scene = ItemGetScene(item)
		
		ItemPhysicSetAngularFactor(item, Vector(0,0,1.0))
		ItemPhysicSetLinearFactor(item,  Vector(1.0,1.0,0.0))
		
		current_velocity = Vector(0,0,0)
		
		//update_function = UpdatePlayerIsAlive
	}
}
