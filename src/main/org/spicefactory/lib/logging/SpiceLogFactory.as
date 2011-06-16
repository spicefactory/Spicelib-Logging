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
 * A <code>LogFactory</code> is responsible for creating and caching <code>Logger</code> instances
 * and offers configuration options for setting log levels and adding <code>Appender</code> instances.
 * Usually you would not use this interface in application code except for startup logic that configures
 * the factory. The default way to obtain <code>Logger</code> instances is the static
 * <code>LogContext.getLogger</code> method of the Spicelib Log Wrapper. 
 * 
 * @author Jens Halm
 */	
public interface SpiceLogFactory extends LogFactory {

	/**
	 * Adds the specified Appender to this LogFactory. Any <code>Logger</code>
	 * instances that have already been created will register with this new <code>Appender</code>
	 * without the need to call <code>refresh</code>.
	 * 
	 * @param app the Appender instance to add to this LogFactory
	 */
	function addAppender (app:Appender) : void;
	
	/**
	 * Sets the root log level for this factory. The root log level specifies the
	 * log level to use for all Logger instances that don't have their own level
	 * set explicitly.
	 */
	function setRootLogLevel (level:LogLevel) : void;
	
	/**
	 * Adds the specified level for the given logger name. The levels are 
	 * organized in a hierarchical way, so if you specify a level for a logger
	 * name "com.mycompany" it is in effect for all names that start with that
	 * substring like "com.mycompany.mypackage.MyClass" except for those that
	 * have their own level set explicitly.
	 * 
	 * <p>If the name parameter is a Class
	 * instance, the fully qualified class name will be used. Otherwise the <code>toString</code>
	 * method will be invoked on the given name instance.</p>
	 * 
	 * @param name the name of the logger to set the level for
	 * @param level the level to set for the specified logger name
	 */
	function addLogLevel (name:Object, level:LogLevel) : void;
	
	/**
	 * Refreshes all existing <code>Logger</code> instances. This might be necessary
	 * if you change the configuration with <code>addLogLevel</code> or <code>setRootLogLevel</code>
	 * after one or more <code>Logger</code> instances have already been created.
	 */
	function refresh () : void;
	
}

}