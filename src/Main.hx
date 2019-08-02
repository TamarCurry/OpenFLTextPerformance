package;

import openfl.Lib;
import openfl.StopWatch;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Tamar Curry
 */
class Main extends Sprite 
{
	public var appendBtnWidth:Float;
	public var clearBtnWidth:Float;
	public var textField:TextField;
	public var textToWrite:String;
	public var appendBtn:Sprite;
	public var clearBtn:Sprite;
	public var holder:Sprite;
	public var resultsTextField:TextField;
	
	// -------------------------------------------------------------------------------------
	public function new() 
	{
		super();
		
		if ( this.stage == null ) {
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		else {
			onInit(null);
		}
	}
	
	// -------------------------------------------------------------------------------------
	private function onInit(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onInit);
		textField = new TextField();
		textField.wordWrap = true;
		textField.multiline = true;
		textField.x = 20;
		textField.y = 20;
		textField.width = 360;
		textField.height = 300;
		textField.text = ". . .\n";
		
		var bg:Shape = new Shape();
		bg.graphics.beginFill(0xcccccc);
		bg.graphics.drawRect(0, 0, textField.width, textField.height);
		bg.graphics.endFill();
		bg.x = textField.x;
		bg.y = textField.y;
		
		addChild(bg);
		addChild(textField);
		
		textToWrite = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ";
		
		appendBtnWidth 	= 150;
		clearBtnWidth 	= 150;
		
		appendBtn 	= makeButton( "Click here to append text", appendBtnWidth );
		clearBtn 	= makeButton( "Click here to clear text", clearBtnWidth );
		
		appendBtn.addEventListener(MouseEvent.CLICK, appendText);
		clearBtn.addEventListener(MouseEvent.CLICK, clearText);
		
		positionButtons();
		
		resultsTextField = new TextField();
		resultsTextField.width = 300;
		resultsTextField.height = 30;
		resultsTextField.x = textField.x + ((textField.width - resultsTextField.width) / 2);
		resultsTextField.y = appendBtn.y + appendBtn.height + 20;
		addChild(resultsTextField);
		
	}
	
	// -------------------------------------------------------------------------------------
	private function makeButton(text:String, buttonWidth:Float):Sprite
	{
		var buttonHeight:Float = 60;
		var buttonTF:TextField = new TextField();
		buttonTF.wordWrap = true;
		buttonTF.multiline = true;
		buttonTF.selectable = false;
		buttonTF.width = buttonWidth - 40;
		buttonTF.height = 20;
		buttonTF.autoSize = TextFieldAutoSize.LEFT;
		buttonTF.htmlText = "<p align='center'><font size='16'>" + text + "</font></p>";
		buttonTF.x = (buttonWidth - buttonTF.width) / 2;
		buttonTF.y = (buttonHeight - buttonTF.height) / 2;
		
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginFill(0x999999);
		sprite.graphics.drawRoundRect(0, 0, buttonWidth, buttonHeight, 8, 8);
		sprite.graphics.endFill();
		sprite.addChild(buttonTF);
		sprite.mouseChildren = false;
		sprite.buttonMode = true;
		
		sprite.addEventListener(MouseEvent.MOUSE_DOWN, scaleButtonDown);
		sprite.addEventListener(MouseEvent.MOUSE_UP, scaleButtonUp);
		sprite.addEventListener(MouseEvent.MOUSE_OUT, scaleButtonUp);
		
		addChild(sprite);
		return sprite;
	}
	
	// -------------------------------------------------------------------------------------
	private function scaleButtonDown(e:MouseEvent):Void
	{
		if ( Std.is( e.target, Sprite ) ) {
			var sprite:Sprite = cast e.target;
			sprite.scaleX = sprite.scaleY = 0.95;
			positionButtons();
		}
	}
	
	// -------------------------------------------------------------------------------------
	private function scaleButtonUp(e:MouseEvent):Void
	{
		if ( Std.is( e.target, Sprite ) ) {
			var sprite:Sprite = cast e.target;
			sprite.scaleX = sprite.scaleY = 1;
			positionButtons();
		}
	}
	
	// -------------------------------------------------------------------------------------
	private function positionButtons():Void
	{
		var spacing:Float = 20;
		var totalW:Float = appendBtnWidth + clearBtnWidth + spacing;
		var centerY:Float = textField.y + textField.height + 40;
		var startX:Float = textField.x + ((textField.width - totalW) / 2);
		
		appendBtn.x = startX + ((appendBtnWidth - appendBtn.width) / 2);
		appendBtn.y = centerY - (appendBtn.height / 2);
		
		clearBtn.x = startX + appendBtnWidth + spacing + ((clearBtnWidth - clearBtn.width)/2);
		clearBtn.y = centerY - (clearBtn.height / 2);
	}
	
	// -------------------------------------------------------------------------------------
	private function appendText(e:MouseEvent):Void
	{
		StopWatch.count = 0;
		var startTime:Int = Lib.getTimer();
		textField.appendText(textToWrite);
		textField.scrollV = textField.maxScrollV;
		var endTime:Int = Lib.getTimer();
		var text:String = "Total time to append: " + (endTime - startTime) + " ms.";
		resultsTextField.htmlText = "<p align='center'><font size='14'>" + text + "</font></p>";
	}
	
	// -------------------------------------------------------------------------------------
	private function clearText(e:MouseEvent):Void
	{
		var startTime:Int = Lib.getTimer();
		textField.text = "";
		textField.scrollV = textField.maxScrollV;
		var endTime:Int = Lib.getTimer();
		var text:String = "Total time to clear: " + (endTime - startTime) + " ms.";
		resultsTextField.htmlText = "<p align='center'><font size='14'>" + text + "</font></p>";
	}
}
