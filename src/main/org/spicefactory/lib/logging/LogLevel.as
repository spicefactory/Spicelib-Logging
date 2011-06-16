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

/**
 * Defines constants for the different log levels used in the framework.
 * 
 * @author Jens Halm
 */	
public class LogLevel {
	
	/**
	 * The level to turn off all logging.
	 */
	public static const OFF:LogLevel = new LogLevel(7, "OFF");
	
	/**
	 * The <code>FATAL</code> level designates very severe error events 
	 * that will presumably lead the application to abort.
	 */
	public static const FATAL:LogLevel = new LogLevel(6, "FATAL");
	
	/**
	 * The <code>ERROR</code> level designates error events 
	 * that might still allow the application to continue running.
	 */
	public static const ERROR:LogLevel = new LogLevel(5, "ERROR");
	
	/**
	 * The <code>WARN</code> level designates potentially harmful situations.
	 */
	public static const WARN:LogLevel = new LogLevel(4, "WARN");
	
	/**
	 * The <code>INFO</code> level designates informational messages 
	 * that highlight the progress of the application at coarse-grained level.
	 */
	public static const INFO:LogLevel = new LogLevel(3, "INFO");
	
	/**
	 * The <code>DEBUG</code> level designates fine-grained informational events 
	 * that are most useful to debug an application.
	 */
	public static const DEBUG:LogLevel = new LogLevel(2, "DEBUG");
	
	/**
	 * The <code>TRACE</code> level designates very fine-grained information and
	 * represents the lowest rank of all levels.
	 */
	public static const TRACE:LogLevel = new LogLevel(1, "TRACE");
	
	
	private var _value:uint;
	private var _string:String;
	
	/**
	 * @private
	 */
	public function LogLevel (value:uint, name:String) {
		_value = value;
		_string = name;
	}
	
	/**
	 * Returns a numeric value representing the log level.
	 * Log levels with higher severity have higher numeric values.
	 * 
	 * @return the numeric value representing this log level
	 */
	public function toValue () : uint {
		return _value;
	}
	
	/**
	 * Returns the String representation for this log level.
	 * 
	 * @return the String representation for this log level
	 */
	public function toString () : String {
		return _string;
	}
	
}

}