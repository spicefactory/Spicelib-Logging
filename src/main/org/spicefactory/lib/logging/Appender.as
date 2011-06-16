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
 * An Appender is a target for log output. All <code>FlashLogger</code> instances
 * route their log output through one or more Appenders.
 * 
 * @author Jens Halm
 */
public interface Appender {
	
	function set threshold (level:LogLevel) : void ;

	/**
	 * The threshold level for this Appender. The Appender threshold is an additional
	 * filtering mechanism to the log level of Logger instances. Any log messages with
	 * a log level below the threshold will be ignored by this Appender.
	 */	
	function get threshold () : LogLevel ;
	
	/**
	 * Registers the specified Logger with this Appender. 
	 * Implementations usually register listeners for LogEvents of the specified Logger.
	 * 
	 * @param logger the logger to register with this Appender
	 */
	function registerLogger (logger:SpiceLogger) : void ;
	
}

}