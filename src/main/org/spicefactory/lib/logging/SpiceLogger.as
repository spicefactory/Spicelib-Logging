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
import flash.events.IEventDispatcher;


/**
 * All logging operations are done through this interface. It contains
 * log methods for all existing log levels, methods to check if a particular
 * log level is active for a Logger instance and the <code>level</code> property
 * for filtering log output.
 * 
 * <p>It extends the basic <code>Logger</code> interface from the core log wrapper.</p>
 * 
 * @author Jens Halm
 */
public interface SpiceLogger extends Logger, IEventDispatcher {
	
	/**
	 * The active level of the logger. Any log operations with a level
	 * lower than the value of this property will be filtered.
	 */
	function get level () : LogLevel;
	
	function set level (level:LogLevel) : void;

	
}

}