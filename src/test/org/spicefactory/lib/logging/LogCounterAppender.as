package org.spicefactory.lib.logging {

import org.spicefactory.lib.logging.impl.AbstractAppender;

import flash.utils.Dictionary;
	
	
public class LogCounterAppender extends AbstractAppender {
	
	
	private var counter:Dictionary = new Dictionary();
	

	function LogCounterAppender () {
		
	}
	
	protected override function handleLogEvent (event:LogEvent) : void {
		if (isBelowThreshold(event.level)) return;
		var loggerName:String = Logger(event.target).name;
		if (counter[loggerName] == undefined) {
			counter[loggerName] = 1;
		} else {
			counter[loggerName]++;
		}		
	}		
	
	
	public function getCount (loggerName:String) : uint {
		return (counter[loggerName] == undefined) ? 0 : counter[loggerName];
	}
	
}

}