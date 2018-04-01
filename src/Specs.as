/*
 * Scratch Project Editor and Player
 * Copyright (C) 2014 Massachusetts Institute of Technology
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

// Specs.as
// John Maloney, April 2010
//
// This file defines the command blocks and categories.
// To add a new command:
//		a. add a specification for the new command to the commands array
//		b. add a primitive for the new command to the interpreter

package {
	import flash.display.Bitmap;
	import assets.Resources;

public class Specs {

	public static const GET_VAR:String = "readVariable";
	public static const SET_VAR:String = "setVar:to:";
	public static const CHANGE_VAR:String = "changeVar:by:";
	public static const GET_LIST:String = "contentsOfList:";
	public static const CALL:String = "call";
	public static const PROCEDURE_DEF:String = "procDef";
	public static const GET_PARAM:String = "getParam";

	public static const motionCategory:int = 1;
	public static const looksCategory:int = 2;
	public static const eventsCategory:int = 5;
	public static const controlCategory:int = 6;
	public static const operatorsCategory:int = 8;
	public static const dataCategory:int = 9;
	public static const myBlocksCategory:int = 10;
	public static const listCategory:int = 12;
	public static const classCategory:int = 16;
	public static const extensionsCategory:int = 20;

	public static var variableColor:int = 0xf6931a;//0xfe5621; // Scratch 1.4: 0xf3761d
	public static var listColor:int = 0xf65c1a;//0xcc5b22; // Scratch 1.4: 0xd94d11
	public static var procedureColor:int = 0x96cdcd;// 0xff6680;//0x673ab7; // 0x531e99;
	public static var parameterColor:int = 0xff4d6b;
	public static var classColor:int = 0x9f79ee;
	public static var extensionsColor:int = 0x4b4a60; // 0x72228c; // 0x672d79;
	
	private static const undefinedColor:int = 0xd42828;
	
	public static const categories:Array = [
	 // id   category name	color
		[0,  "undefined",	0xD42828],
		[1,  "Motion",		0x4c97ff],
		[2,  "Looks",		0x9765fa],
		[3,  "Sound",		0xd362d7],
		[4,  "Pen",			0x07b092],
		[5,  "Events",		0xfdd200],
		[6,  "Control",		0xfca51b],
		[7,  "Sensing",		0x48bcee],
		[8,  "Operators",	0x42bd4b],
		[9,  "Data",		variableColor],
		[10, "Function",	procedureColor],
		[11, "Parameter",	parameterColor],
		[12, "List",		listColor],
		[13, "Clip Blocks",	0x00ccff],
		[14, "Clip Plugins",0x2683f5],
		[15, "Arduino",		0x00e676],
		[16, "Class",		classColor],
		[20, "Extension",	extensionsColor],
	];
	public static function blockColor(categoryID:int):int {
		if (categoryID > 100) categoryID -= 100;
		for each (var entry:Array in categories) {
			if (entry[0] == categoryID) return entry[2];
		}
		return undefinedColor;
	}

	public static function entryForCategory(categoryName:String):Array {
		for each (var entry:Array in categories) {
			if (entry[1] == categoryName) return entry;
		}
		return [1, categoryName, 0xFF0000]; // should not happen
	}

	public static function nameForCategory(categoryID:int):String {
		if (categoryID > 100) categoryID -= 100;
		for each (var entry:Array in categories) {
			if (entry[0] == categoryID) return entry[1];
		}
		return "Unknown";
	}

	public static function IconNamed(name:String):* {
		// Block icons are 2x resolution to look better when scaled.
		var icon:Bitmap;
		if (name == "greenFlag") icon = Resources.createBmp('flagIcon');
		if (name == "stop") icon = Resources.createBmp('stopIcon');
		if (name == "turnLeft") icon = Resources.createBmp('turnLeftIcon');
		if (name == "turnRight") icon = Resources.createBmp('turnRightIcon');
		if (icon != null) icon.scaleX = icon.scaleY = 0.5;
		return icon;
	}

	public static var commands:Array = [
		// block specification					type, cat, opcode			default args (optional)
		// motion
		["move %n steps",						" ", 1, "forward:",					10],
		["turn @turnRight %n degrees",			" ", 1, "turnRight:",				15],
		["turn @turnLeft %n degrees",			" ", 1, "turnLeft:",				15],
		["--"],
		["point in direction %d.direction",		" ", 1, "heading:",					90],
		["point towards %m.spriteOrMouse",		" ", 1, "pointTowards:",			"_mouse_"],
		["--"],
		["go to x:%n y:%n",						" ", 1, "gotoX:y:"],
		["go to %m.location",					" ", 1, "gotoSpriteOrMouse:",		"_mouse_"],
		["glide %n secs to x:%n y:%n",			" ", 1, "glideSecs:toX:y:elapsed:from:"],
		["--"],
		["change x by %n",						" ", 1, "changeXposBy:",			10],
		["set x to %n",							" ", 1, "xpos:",					0],
		["change y by %n",						" ", 1, "changeYposBy:",			10],
		["set y to %n",							" ", 1, "ypos:",					0],
		["--"],
		["if on edge, bounce",					" ", 1, "bounceOffEdge"],
		["-"],
		["set rotation style %m.rotationStyle",	" ", 1, "setRotationStyle", 		"left-right"],
		["--"],
		["x position",							"r", 1, "xpos"],
		["y position",							"r", 1, "ypos"],
		["direction",							"r", 1, "heading"],

		// looks
		["say %s for %n secs",					" ", 2, "say:duration:elapsed:from:",	"你好!", 2],
		["say %s",								" ", 2, "say:",							"你好!"],
		["think %s for %n secs",				" ", 2, "think:duration:elapsed:from:", "嗯...", 2],
		["think %s",							" ", 2, "think:",						"嗯..."],
		["-"],
		["show",								" ", 2, "show"],
		["hide",								" ", 2, "hide"],
		["-"],
		["switch costume to %m.costume",		" ", 2, "lookLike:",				"角色1"],
		["next costume",						" ", 2, "nextCostume"],
		["switch backdrop to %m.backdrop",		" ", 2, "startScene", 				"背景1"],
		["-"],
		["change %m.effect effect by %n",		" ", 2, "changeGraphicEffect:by:",	"color", 25],
		["set %m.effect effect to %n",			" ", 2, "setGraphicEffect:to:",		"color", 0],
		["clear graphic effects",				" ", 2, "filterReset"],
		["-"],
		["change size by %n",					" ", 2, "changeSizeBy:",	 		10],
		["set size to %n%",						" ", 2, "setSizeTo:", 				100],
		["-"],
		["go to front",							" ", 2, "comeToFront"],
		["go back %n layers",					" ", 2, "goBackByLayers:", 			1],
		["-"],
		["costume #",							"r", 2, "costumeIndex"],
		["backdrop name",						"r", 2, "sceneName"],
		["size",								"r", 2, "scale"],
		["-"],
		["*当前角色所在的图层", 				"r", 2, "layer"],
		["*角色名称",							"r", 2, "costumeName"],
		["* %m.effect 特效值",					"r", 2, "effect", "ghost"],
		// stage looks
		["switch backdrop to %m.backdrop",			" ", 102, "startScene", 			"backdrop1"],
		["switch backdrop to %m.backdrop and wait", " ", 102, "startSceneAndWait",		"backdrop1"],
		["next backdrop",							" ", 102, "nextScene"],
		["-"],
		["change %m.effect effect by %n",		" ", 102, "changeGraphicEffect:by:",	"color", 25],
		["set %m.effect effect to %n",			" ", 102, "setGraphicEffect:to:",		"color", 0],
		["clear graphic effects",				" ", 102, "filterReset"],
		["-"],
		["backdrop name",						"r", 102, "sceneName"],
		["backdrop #",							"r", 102, "backgroundIndex"],

		// sound
		["play sound %m.sound",					" ", 3, "playSound:",						"drop"],
		["play sound %m.sound until done",		" ", 3, "doPlaySoundAndWait",				"drop"],
		["stop all sounds",						" ", 3, "stopAllSounds"],
		["-"],
		["play drum %d.drum for %n beats",		" ", 3, "playDrum",							1, 0.25],
		["rest for %n beats",					" ", 3, "rest:elapsed:from:",				0.25],
		["-"],
		["play note %d.note for %n beats",		" ", 3, "noteOn:duration:elapsed:from:",	60, 0.5],
		["set instrument to %d.instrument",		" ", 3, "instrument:",						1],

		["-"],
		["change volume by %n",					" ", 3, "changeVolumeBy:",					-10],
		["set volume to %n%",					" ", 3, "setVolumeTo:", 					100],
		["volume",								"r", 3, "volume"],
		["-"],
		["change tempo by %n",					" ", 3, "changeTempoBy:",					20],
		["set tempo to %n bpm",					" ", 3, "setTempoTo:",						60],
		["tempo",								"r", 3,  "tempo"],

		// pen
		["clear",								" ", 4, "clearPenTrails"],
		["-"],
		["stamp",								" ", 4, "stampCostume"],
		["-"],
		["pen down",							" ", 4, "putPenDown"],
		["pen up",								" ", 4, "putPenUp"],
		["-"],
		["set pen color to %c",					" ", 4, "penColor:"],
		["change pen color by %n",				" ", 4, "changePenHueBy:"],
		["set pen color to %n",					" ", 4, "setPenHueTo:", 		0],
		["-"],
		["change pen shade by %n",				" ", 4, "changePenShadeBy:"],
		["set pen shade to %n",					" ", 4, "setPenShadeTo:",		50],
		["-"],
		["change pen size by %n",				" ", 4, "changePenSizeBy:",		1],
		["set pen size to %n",					" ", 4, "penSize:", 			1],
		["-"],

		// stage pen
		["clear",								" ", 104, "clearPenTrails"],

		// triggers
		["when @greenFlag clicked",				"h", 5, "whenGreenFlag"],
		["when %m.key key pressed",				"h", 5, "whenKeyPressed", 		"space"],
		["when this sprite clicked",			"h", 5, "whenClicked"],
		["when backdrop switches to %m.backdrop", "h", 5, "whenSceneStarts", 	"背景1"],
		["--"],
		["when %m.triggerSensor > %n",			"h", 5, "whenSensorGreaterThan", "loudness", 10],
		["--"],
		["when I receive %m.broadcast",			"h", 5, "whenIReceive",			""],
		["broadcast %m.broadcast",				" ", 5, "broadcast:",			""],
		["broadcast %m.broadcast and wait",		" ", 5, "doBroadcastAndWait",	""],

		// control - sprite
		["wait %n secs",						" ", 6, "wait:elapsed:from:",	1],
		["-"],
		["repeat %n",							"c", 6, "doRepeat", 10],
		["forever",								"cf",6, "doForever"],
		["-"],
		["if %b then",							"c", 6, "doIf"],
		["if %b then",							"e", 6, "doIfElse"],
		["wait until %b",						" ", 6, "doWaitUntil"],
		["repeat until %b",						"c", 6, "doUntil"],
		["repeat while %b",						"c", 6, "doWhile"],
		["-"],
		["stop %m.stop",						"f", 6, "stopScripts", "all"],
		["-"],
		["when I start as a clone",				"h", 6, "whenCloned"],
		["create clone of %m.spriteOnly",		" ", 6, "createCloneOf"],
		["delete this clone",					"f", 6, "deleteClone"],
		["-"],

		// control - stage
		["wait %n secs",						" ", 106, "wait:elapsed:from:",	1],
		["-"],
		["repeat %n",							"c", 106, "doRepeat", 10],
		["forever",								"cf",106, "doForever"],
		["-"],
		["if %b then",							"c", 106, "doIf"],
		["if %b then",							"e", 106, "doIfElse"],
		["wait until %b",						" ", 106, "doWaitUntil"],
		["repeat until %b",						"c", 106, "doUntil"],
		["repeat while %b",						"c", 106, "doWhile"],
		["-"],
		["stop %m.stop",						"f", 106, "stopScripts", "all"],
		["-"],
		["create clone of %m.spriteOnly",		" ", 106, "createCloneOf"],

		// sensing
		["touching %m.touching?",				"b", 7, "touching:",			"_mouse_"],
		["*碰到 %m.spriteOnly 对于克隆体序号为 %n 的克隆体?",	"b", 7, "touching:no:",			"", 1],
		["touching color %c?",					"b", 7, "touchingColor:"],
		["color %c is touching %c?",			"b", 7, "color:sees:"],
		["distance to %m.spriteOrMouse",		"r", 7, "distanceTo:",			"_mouse_"],
		["-"],
		["ask %s and wait",						" ", 7, "doAsk", 				"你叫什么名字?"],
		["answer",								"r", 7, "answer"],
		["-"],
		["key %m.key pressed?",					"b", 7, "keyPressed:",			"space"],
		["mouse down?",							"b", 7, "mousePressed"],
		["mouse x",								"r", 7, "mouseX"],
		["mouse y",								"r", 7, "mouseY"],
		["-"],
		["loudness",							"r", 7, "soundLevel"],
		["-"],
		["video %m.videoMotionType on %m.stageOrThis", "r", 7, "senseVideoMotion", "motion"],
		["turn video %m.videoState",			" ", 7, "setVideoState",			"on"],
		["set video transparency to %n%",		" ", 7, "setVideoTransparency",		50],
		["-"],
		["timer",								"r", 7, "timer"],
		["reset timer",							" ", 7, "timerReset"],
		["-"],
		["%m.attribute of %m.spriteOrStage",	"r", 7, "getAttribute:of:"],
		["*是克隆体吗?",								"b", 7, "isClone"],
		["-"],
		["current %m.timeAndDate", 				"r", 7, "timeAndDate",			"minute"],
		["days since 2000", 					"r", 7, "timestamp"],
		["username",							"r", 7, "getUserName"],
		["-"],
		["*克隆体序号",		"r", 7, "cloneIndex"],
		["*角色总数",								"r", 7, "countSprites"],
		["*叫 %m.spriteOnly 的角色总数",								"r", 7, "countSpritesNamed:"],
		["*%m.spriteOnly 的克隆体是否有一个的序号为 %n ?",				"b", 7, "clone:no:exists"],
		["-"],
		["*在快速模式中吗?", 								"b", 7, "turbo"],
		["*开启快速模式",		" ", 7, "turboOn",],
		["*关闭快速模式",		" ", 7, "turboOff"],
		["*在全屏中吗?", 								"b", 7, ""],
		["%m.spriteOnly",				"r", 7, "thisName"],
		["*将这个角色重命名为 %s",								" ", 7, "setName"],
		["-"],

		// stage sensing
		["ask %s and wait",						" ", 107, "doAsk", 				"你叫什么名字?"],
		["answer",								"r", 107, "answer"],
		["-"],
		["key %m.key pressed?",					"b", 107, "keyPressed:",		"space"],
		["mouse down?",							"b", 107, "mousePressed"],
		["mouse x",								"r", 107, "mouseX"],
		["mouse y",								"r", 107, "mouseY"],
		["-"],
		["loudness",							"r", 107, "soundLevel"],
		["-"],
		["video %m.videoMotionType on %m.stageOrThis", "r", 107, "senseVideoMotion", "motion", "Stage"],
		["turn video %m.videoState",			" ", 107, "setVideoState",			"on"],
		["set video transparency to %n%",		" ", 107, "setVideoTransparency",	50],
		["-"],
		["timer",								"r", 107, "timer"],
		["reset timer",							" ", 107, "timerReset"],
		["-"],
		["%m.attribute of %m.spriteOrStage",	"r", 107, "getAttribute:of:"],
		["-"],
		["current %m.timeAndDate", 				"r", 107, "timeAndDate",		"minute"],
		["days since 2000", 					"r", 107, "timestamp"],
		["username",							"r", 107, "getUserName"],
		["-"],
		["*在快速模式中吗?", 								"b", 7, "turbo"],
		["*开启快速模式",		" ", 107, "turboOn",],
		["*关闭快速模式",		" ", 107, "turboOff"],
		["*在全屏中吗?", 								"b", 107, ""],
		["-"],

		// operators
		["%n + %n",								"r", 8, "+",					"", ""],
		["%n - %n",								"r", 8, "-",					"", ""],
		["%n * %n",								"r", 8, "*",					"", ""],
		["%n / %n",								"r", 8, "/",					"", ""],
		["-"],
		["*%n 和 %n 的最大公约数",				"r", 8, "Greatestcommondivisor",					"", ""],
		["*%n 和 %n 的最小公倍数",				"r", 8, "Leastcommonmultiple",					"", ""],
		["-"],
		["-"],
		["pick random %n to %n",				"r", 8, "randomFrom:to:",		1, 10],
		["-"],
		["*十进制%n 转为二进制",				"r", 8, "tobin",					"", ""],
		["*二进制%n 转为十进制",				"r", 8, "todec",					"", ""],
		["-"],
		["*字符%s 转为Ascll",					"r", 8, "getascll",					"A"],
		["*Ascll%n 转为字符",					"r", 8, "ascllgetchar",					"65"],
		["*字符%s 转为Unicode",					"r", 8, "getunicode",					"字"],
		["*Unicode%n 转为字符",					"r", 8, "unicodegetchar",					"23383"],
		["-"],
		["%s < %s",								"b", 8, "<",					"", ""],
		["%s = %s",								"b", 8, "=",					"", ""],
		["%s > %s",								"b", 8, ">",					"", ""],
		["-"],
		["*%s ≤ %s",							"b", 8, "≤",					"", ""],
		["*%s ≠ %s",							"b", 8, "≠",					"", ""],
		["*%s ≥ %s",							"b", 8, "≥",					"", ""],
		["-"],
		["%b and %b",							"b", 8, "&"],
		["%b or %b",							"b", 8, "|"],
		["not %b",								"b", 8, "not"],
		["-"],
		["join %s %s",							"r", 8, "concatenate:with:",	"文本1连接到了 ", "文本2"],
		["letter %n of %s",						"r", 8, "letter:of:",			1, "文本1"],
		["length of %s",						"r", 8, "stringLength:",		"文本1"],
		["-"],
		["%n mod %n",							"r", 8, "%",					"", ""],
		["round %n",							"r", 8, "rounded", 				""],
		["-"],
		["%m.mathOp of %n",						"r", 8, "computeFunction:of:",	"sqrt", 9],
		["*对%n 开 %n 次根",					"r", 8, "root",					"", ""],
		// variables
		["set %m.var to %s",					" ", 9, SET_VAR],
		["change %m.var by %n",					" ", 9, CHANGE_VAR],
		["show variable %m.var",				" ", 9, "showVariable:"],
		["hide variable %m.var",				" ", 9, "hideVariable:"],
		["-"],
		["*在屏幕上展示 %m.var",				" ", 9, "printTxt"],	
		["*显示 %m.var 的展示",					" ", 9, "showTxt"],	
		["*隐藏 %m.var 的展示",					" ", 9, "hideTxt"],
		["-"],
		["*将 %m.var 的展示大小改为 %n",		" ", 9, "set:PrintSize:"],	
		["*将 %m.var 的展示颜色改为 %c",		" ", 9, "set:PrintColor:"],
		["*将 %m.var 展示的位置改到 x:%n y:%n",	" ", 9, "set:PrintX:Y:"],
		["-"],
		["*将 %m.var 的展示宽度改为 %n",		" ", 9, "set:PrintWidth:"],
		["*将 %m.var 的展示高度改为 %n",		" ", 9, "set:PrintHeight:"],
		["*将 %m.var 的对齐方式改为 %m.print",	" ", 9, "set:PrintAlign:"],
		["-"],
		["*将 %m.var 的展示背景颜色改为 %c",	" ", 9, "set:PrintBackground:"],
		["*显示 %m.var 的展示背景",				" ", 9, "show:PrintBackground"],
		["*隐藏 %m.var 的展示背景",				" ", 9, "hide:PrintBackground"],				
		["-"],
		["*将 %m.var 的展示边框颜色改为 %c",	" ", 9, "set:PrintBorder:"],
		["*显示 %m.var 的展示边框",				" ", 9, "show:PrintBorder"],
		["*隐藏 %m.var 的展示边框",				" ", 9, "hide:PrintBorder"],
		
		// function
		["%s",									" ", 10, "function:string"],
		["%n",									" ", 10, "function:number"],
		["%b",									" ", 10, "function:boolean"],
		["-"],
		["Return %s",							" ", 10, "return:string"],
		["Return %n",							" ", 10, "return:number"],
		["Return %b",							" ", 10, "return:boolean"],

		// lists
		["add %s to %m.list",					" ", 12, "append:toList:"],
		["-"],
		["delete %d.listDeleteItem of %m.list",	" ", 12, "deleteLine:ofList:"],
		["insert %s at %d.listItem of %m.list",	" ", 12, "insert:at:ofList:"],
		["replace item %d.listItem of %m.list with %s",	" ", 12, "setLine:ofList:to:"],
		["-"],
		["item %d.listItem of %m.list",			"r", 12, "getLine:ofList:"],
		["length of %m.list",					"r", 12, "lineCountOfList:"],
		["%m.list contains %s?",				"b", 12, "list:contains:"],
		["-"],
		["show list %m.list",					" ", 12, "showList:"],
		["hide list %m.list",					" ", 12, "hideList:"],

		
		//Arduino
		[" 设置数字口 %n 为 %d.output",       	" ",15,"digitalIo:",          3,1], 
		
		//club
		
		["*创建变量 %s",						" ", 13, "createVar", "变量名"],
		["*删除变量 %s",						" ", 13, "deleteVar", "变量名"],
		["*变量 %s 是否存在",					"r", 13, "lookup", "变量名"],
		["*变量 %s 的值",						"r", 13, "getVariableValue", "变量名"],
		["-"],
		["-"],
		["*显示提示框 标题:%s 内容:%s 左对齐:%m.char 按钮提示:%s",						" ", 13, "showtip",		'标题','内容',"false","确定"],
		["*显示带有返回值的提示框 标题:%s 内容:%s 预填内容:%s 左对齐:%m.char 按钮提示:%s",						" ", 13, "showReturnValueTip",		'标题','内容','预填内容',"false","确定"],
		//		["*返回值",						"r", 2, "costumeName"],
		["-"],
		["-"],
		["*距离从 (x:%n ,y:%n ) 到 (x:%n ,y:%n ) ",						"r", 13, "dFromX1:Y1:toX2:Y2:", 0, 0, 0, 0],
		["*距离从 %m.spriteOnly 到 %m.spriteOnly",				"r", 13, "dFrom:to:"],
		["*总共的x单元个数从 %m.spriteOnly 到 %m.spriteOnly",		"r", 13, "uxFrom:to:"],
		["*总共的y单元个数从 %m.spriteOnly 到 %m.spriteOnly",		"r", 13, "uyFrom:to:"],
		["*总共的x单元个数从 (%n ,%n ) 到 (%n ,%n ) ",		"r", 13, "uxFromX1:Y1:toX2:Y2:", 0, 0, 0, 0],
		["*总共的y单元个数从 (%n ,%n ) 到 (%n ,%n ) ",		"r", 13, "uyFromX1:Y1:toX2:Y2:", 0, 0, 0, 0],
		["*x单元个数对于 %n @ %d.direction",		"r", 13, "xCompOf:at:", 25, 45],
		["*y单元个数对于 component of %n @ %d.direction",		"r", 13, "yCompOf:at:", 25, 45],
		["*方向从 (%n ,%n )  到 (%n ,%n ) ",				"r", 13, "dirFromX1:Y1:toX2:Y2:", 0, 0, 0, 0],
		["*方向从 %m.spriteOnly 到 %m.spriteOnly",		"r", 13, "dirFrom:to:"],
		["*方向对于 Δx: %n Δy: %n",		"r", 13, "dirForX:Y:"],
		["*设置 %m.attribute 对于 %m.spriteOnly 克隆体编号 %n 至 %s",	" ", 13, "setAttr:of:no:to:", "x position", "_myself_" , 1, 0],
		["*给这个角色添加 %s 标签",	" ", 13, "addTag:", ""],
		["*给这个角色删除 %s 标签",	" ", 13, "deleteTag:", ""],
		["*添加 %s 标签至 %m.spriteOnly 克隆体序号： %n",	" ", 13, "addTag:to:no:", "", "_myself_", 1],
		["*删除 %s 标签至 %m.spriteOnly 克隆体序号： %n",	" ", 13, "deleteTag:from:no:", "", "_myself_", 1],
		["*标签的序号 %n",	"r", 13, "getTagNo:", 1],
		["*标签总数",	"r", 13, "countTags"],
		["*获得标签的序号 %n 对于 %m.spriteOnly 克隆体编号： %n",	"r", 13, "getTagNo:of:clone:", 1, "_myself_", 1],
		//["*标签总数 %m.spriteOnly 克隆体编号： %n",	"r", 13, "countTagsOf:clone:", "_myself_",1],
		["*有标签 %s 吗?",	"b", 13, "hasTag:"],
		["* %m.spriteOnly 克隆体序号： %n 有标签 %s 吗?",	"b", 13, "clone:no:hasTag:", "_myself_",1, ""],
		//["on stage?",	"b", 13, "onStage"],
		//["不在容器内",						"r", 14, "Donothing"],		
		["访问网页 %s",									" ", 14, "goto	Web", "http://www.baidu.com"],
		["关闭浏览器",									" ", 14, "closeWeb"],
		["写入剪贴板 %s",									" ", 14, "writeClipBoard", "填写您想要的文字"],
		["读取剪贴板",	"r", 14, "clipboard"],
		
		
		// obsolete blocks from Scratch 1.4 that may be used in older projects
		["play drum %n for %n beats",			" ", 98, "drum:duration:elapsed:from:", 1, 0.25], // Scratch 1.4 MIDI drum
		["set instrument to %n",				" ", 98, "midiInstrument:", 1],
		["loud?",								"b", 98, "isLoud"],

		// obsolete blocks from Scratch 1.4 that are converted to new forms (so should never appear):
		["abs %n",								"r", 98, "abs"],
		["sqrt %n",								"r", 98, "sqrt"],
		["stop script",							"f", 98, "doReturn"],
		["stop all",							"f", 98, "stopAll"],
		["switch to background %m.costume",		" ", 98, "showBackground:", "backdrop1"],
		["next background",						" ", 98, "nextBackground"],
		["forever if %b",						"cf",98, "doForeverIf"],

		// testing and experimental control prims
		["noop",								"r", 99, "COUNT"],
		["counter",								"r", 99, "COUNT"],
		["clear counter",						" ", 99, "CLR_COUNT"],
		["incr counter",						" ", 99, "INCR_COUNT"],
		["for each %m.varName in %s",			"c", 99, "doForLoop", "v", 10],
		["while %b",							"c", 99, "doWhile"],
		["all at once",							"c", 99, "warpSpeed"],

		// stage motion (scrolling)
		["scroll right %n",						" ", 99, "scrollRight",		10],
		["scroll up %n",						" ", 99, "scrollUp",		10],
		["align scene %m.scrollAlign",			" ", 99, "scrollAlign",		'bottom-left'],
		["x scroll",							"r", 99, "xScroll"],
		["y scroll",							"r", 99, "yScroll"],

		// other obsolete blocks from alpha/beta
		["hideAllSprites(Experimental)",					" ", 102, "hideAll"],
		["user id",								"r", 99, "getUserId"],

	];
}}