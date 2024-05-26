

class Character
{

	mat		=	0
	image	=	0

	//-----------------------
	function	OnSetup(item)
	{
		print("Character::OnSetup()")
		mat = GeometryGetMaterialFromIndex(ItemGetGeometry(item), 0)
	}

	function	OnUpdate(item)
	{
		//ItemSetOpacity(item, Irand(0,7).tofloat() * 0.125)
		local	_k = ((image.tointeger())%8).tofloat() * 0.125
		MaterialSetAmbient(mat, Vector(_k,_k,_k,_k))
		image += (g_dt_frame * 10.0)
	}
}