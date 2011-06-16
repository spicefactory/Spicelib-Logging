package org.spicefactory.lib.logging {

import org.flexunit.assertThat;
import org.hamcrest.object.equalTo;
import org.spicefactory.lib.logging.impl.DefaultLogFactory;

public class LoggingTest {
	
	
	[Before]
	public function setUp () : void {
		var factory:SpiceLogFactory = new DefaultLogFactory();
		factory.setRootLogLevel(LogLevel.TRACE);
		factory.refresh();
		LogContext.factory = factory;	
	}
	
	
	[Test]
	public function singleAppender () : void {
		var counter:LogCounterAppender = new LogCounterAppender();
		SpiceLogFactory(LogContext.factory).addAppender(counter);
		logAllLevels(counter);
	}
	
	[Test]
	public function twoAppenders () : void {
		var counter1:LogCounterAppender = new LogCounterAppender();
		var counter2:LogCounterAppender = new LogCounterAppender();
		counter2.threshold = LogLevel.WARN;
		SpiceLogFactory(LogContext.factory).addAppender(counter1);
		SpiceLogFactory(LogContext.factory).addAppender(counter2);
		logAllLevels(counter1);
		assertLogCount(counter2, "foo", 3);
		assertLogCount(counter2, "foo.bar", 0);
		assertLogCount(counter2, "foo.other", 3);
		assertLogCount(counter2, "other", 3);
		assertLogCount(counter2, "log.debug", 3);
		assertLogCount(counter2, "log.info", 3);
		assertLogCount(counter2, "log.error", 2);
		assertLogCount(counter2, "log.fatal", 1);			
	}
	
	[Test]
	public function switchContextFactory () : void {
		var counter:LogCounterAppender = new LogCounterAppender();
		SpiceLogFactory(LogContext.factory).addAppender(counter);
		var logger:Logger = LogContext.getLogger("foo");
		log(logger);
		assertThat(counter.getCount("foo"), equalTo(6));
		
		var counter2:LogCounterAppender = new LogCounterAppender();
		var factory:SpiceLogFactory = new DefaultLogFactory();
		factory.setRootLogLevel(LogLevel.TRACE);
		factory.addAppender(counter2);
		factory.addLogLevel("foo", LogLevel.ERROR);
		factory.refresh();
		LogContext.factory = factory;
		log(logger);
		assertThat(counter2.getCount("foo"), equalTo(2));
	}
	
	[Test]
	public function classInstanceAsLoggerName () : void {
		var counter:LogCounterAppender = new LogCounterAppender();
		SpiceLogFactory(LogContext.factory).addAppender(counter);
		var logger:Logger = LogContext.getLogger(LoggingTest);
		log(logger);
		assertThat(counter.getCount("org.spicefactory.lib.logging::LoggingTest"), equalTo(6));
	}
	
	[Test]
	public function logMessageParameters () : void {
		var app:CachingAppender = new CachingAppender();
		SpiceLogFactory(LogContext.factory).addAppender(app);
		var logger:Logger = LogContext.getLogger(LoggingTest);
		logger.warn("AA {0} BB{1}CC", "foo", 27);
		assertThat(app.getCount("org.spicefactory.lib.logging::LoggingTest"), equalTo(1));
		assertThat(app.getCache("org.spicefactory.lib.logging::LoggingTest")[0], equalTo("AA foo BB27CC"));
	}
	
	private function basicLoggerTest (counter:LogCounterAppender, 
			name:String, level:LogLevel, count:uint) : void {
		if (level != null) {
			SpiceLogFactory(LogContext.factory).addLogLevel(name, level);
			SpiceLogFactory(LogContext.factory).refresh();
		}	
		log(LogContext.getLogger(name));
		assertLogCount(counter, name, count);
	}
	
	private function assertLogCount (counter:LogCounterAppender, name:String, count:uint) : void {
		assertThat(counter.getCount(name), equalTo(count));
	}
	
	private function logAllLevels (counter:LogCounterAppender) : void {
		basicLoggerTest(counter, "foo", LogLevel.WARN, 3);
		basicLoggerTest(counter, "foo.bar", LogLevel.OFF, 0);
		basicLoggerTest(counter, "foo.other", null, 3);
		basicLoggerTest(counter, "other", null, 6);
		basicLoggerTest(counter, "log.debug", LogLevel.DEBUG, 5);
		basicLoggerTest(counter, "log.info", LogLevel.INFO, 4);
		basicLoggerTest(counter, "log.error", LogLevel.ERROR, 2);
		basicLoggerTest(counter, "log.fatal", LogLevel.FATAL, 1);
	}
	
	
	private function log (logger:Logger) : void {
		var msg:String = "The message does not matter";
		logger.trace(msg);
		logger.debug(msg);
		logger.info(msg);
		logger.warn(msg);
		logger.error(msg);
		logger.fatal(msg);
	}
	
	
	
}

}