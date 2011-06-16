/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.logging.impl {
	import org.spicefactory.lib.logging.LogEvent;
	import org.spicefactory.lib.logging.LogLevel;
	import org.spicefactory.lib.logging.SpiceLogger;
	
	
	
/**
 * Appender implementation that uses the trace function of the Flash Player for 
 * all log output.
 * 
 * @author Jens Halm
 */
public class TraceAppender extends AbstractAppender {

		
	private var needsLineFeed:Boolean;
	
	
	/**
	 * Creates a new instance.
	 */
	public function TraceAppender () {
		super();
		needsLineFeed = false;
	}
	
	/**
	 * @private
	 */
	protected override function handleLogEvent (event:LogEvent) : void {
		if (isBelowThreshold(event.level)) return;
		var loggerName:String = SpiceLogger(event.target).name;
		var logMessage:String;
		if ((event.level.toValue() <= LogLevel.INFO.toValue())) {
			var levelString:String = (event.level == LogLevel.DEBUG) ? "DEBUG: " : "INFO:  ";
			loggerName = loggerName.replace("::", ".");
			var index:int = loggerName.lastIndexOf(".");
			if (index != -1) loggerName = loggerName.substring(index + 1);
			logMessage = levelString + loggerName + " - " + event.message;
			needsLineFeed = true;
		} else {
			var lf:String = (needsLineFeed) ? "\n" : "";
			logMessage = lf + "  *** " + event.level + " *** " + loggerName + " ***\n" 
				+ event.message + "\n";
			needsLineFeed = false;
		}
		trace(logMessage);
	}		
		
}
	
}