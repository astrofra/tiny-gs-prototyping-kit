/* UI
*/

g_ui_IDs			<-	0
g_hud_font_color	<-	Vector(0,0,0,255)

function	CreateNewUIID()
{
	g_ui_IDs++
	return g_ui_IDs
}

function	UICommonSetup(ui)
{
//	UILoadFont("ui/arial.ttf")
}

//------------
class	BaseUI
//------------
{
	ui				=	0
	cursor_sprite	=	0

	cursor_prev_x	=	0
	cursor_prev_y	=	0

	fade_timeout	=	0
	cursor_opacity	=	1.0

	//--------------
	constructor(_ui)
	//--------------
	{
		ui = _ui
		local	_texture = EngineLoadTexture(g_engine, "ui/cursor.png")

		if (!IsTouchPlatform())
		{
			cursor_sprite = UIAddSprite(ui, -1, _texture, 0, 0, TextureGetWidth(_texture),	TextureGetHeight(_texture))
			WindowSetScale(cursor_sprite, 2.0, 2.0)
			WindowSetZOrder(cursor_sprite, -1)
		}

		fade_timeout = g_clock
		cursor_opacity	=	1.0
	}

	function	FadeTimeout()
	{
		if ((g_clock - fade_timeout) > SecToTick(Sec(5.0)))
			cursor_opacity = Clamp((cursor_opacity - g_dt_frame), 0.0, 1.0)
		else
			cursor_opacity = Clamp((cursor_opacity + 10.0 * g_dt_frame), 0.0, 1.0)

		WindowSetOpacity(cursor_sprite, cursor_opacity)	
	}

	//------------------------
	function	UpdateCursor()
	//------------------------
	{
		local ui_device = GetInputDevice("mouse")
		local	_x, _y, _dx, _dy
		_x = DeviceInputValue(ui_device, DeviceAxisX)
		_y = DeviceInputValue(ui_device, DeviceAxisY)

		UISetCursorState(ui, g_ui_cursor, _x, _y, DeviceIsKeyDown(ui_device, KeyButton0))

		_dx = Abs(_x - cursor_prev_x)
		_dy = Abs(_y - cursor_prev_y)

		cursor_prev_x = _x
		cursor_prev_y = _y

		if (!IsTouchPlatform())
		{
			//	Actual desktop cursor
			local	dr = RendererGetViewport(g_render)

			local	viewport_ar = dr.z / dr.w
			local	reference_ar = 1280.0 / 960.0

			local	kx = viewport_ar / reference_ar, ky = 1.0

			_x = (_x - 0.5) * kx + 0.5
			_y = (_y - 0.5) * ky + 0.5

			WindowSetPosition(cursor_sprite, _x * 1280.0, _y * 960.0)

			if ((_dx > 0.0) || (_dx > 0.0))
				fade_timeout = g_clock

			FadeTimeout()
	
		}

	}

}