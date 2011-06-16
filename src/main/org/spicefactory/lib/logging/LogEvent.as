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
 
package org.spicefactory.lib.logging {

import flash.events.Event;

/**
 * Event that fires when a log method is invoked in a <code>FlashLogger</code> instance. 
 * 
 * @author Jens Halm
 */
public class LogEvent extends Event {


	private var _level:LogLevel;
	private var _message:String;
	
	/**
	 * Constant for the type of event fired when 
	 * a log method is invoked in a <code>Logger</code> instance.
	 * 
	 * @eventType log
	 */
	public static const LOG:String = "log";
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param level the level that is associated with this event
	 * @param message the log message for this event
	 * @param error an optional Error instance associated with this event
	 */
	function LogEvent (level:LogLevel, message:String) {
		super(LOG);
		_level = level;
		_message = message;
	}
	
	/**
	 * The level for this event.
	 */
	public function get level () : LogLevel {
		return _level;
	}
	
	/**
	 * The message for this event.
	 */
	public function get message () : String {
		return _message;
	}
	
	/**
	 * @private
	 */
	public override function clone () : Event {
		return new LogEvent(level, message);
	}
		

}

}