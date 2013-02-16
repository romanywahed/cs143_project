# add your scheduling algorithms here!
SCHEDULING_ALGORITHMS =  RandomSchedulingAlgorithm.java FCFSSchedulingAlgorithm.java SJFSchedulingAlgorithm.java PrioritySchedulingAlgorithm.java RoundRobinSchedulingAlgorithm.java
############################################

#Build up SOURCES to include all java files in the package directory with full relative pathnames
PACKAGE_DIR = src/com/jimweller/cpuscheduler
RAW_SOURCES = ClockPanel.java BetterFileFilter.java CPUScheduler.java CPUSchedulerFrame.java CPUSchedulerFrameForApplet.java JunkApplet.java JunkGenerator.java MainApp.java Process.java ProcessPanel.java StatsPanel.java SchedulingAlgorithm.java BaseSchedulingAlgorithm.java
RAW_SOURCES += $(SCHEDULING_ALGORITHMS)
SOURCES = $(foreach s, $(RAW_SOURCES), $(PACKAGE_DIR)/$(s))
PICS_DIR = src/pics
CLASSPATH = $(PICS_DIR):src:.:$(PACKAGE_DIR):src/lib/reflections.jar:src/lib/dom4j-1.6.1.jar:src/lib/gson-1.4.jar:src/lib/guava-r08.jar:src/lib/javassist-3.12.1.GA.jar:src/lib/jboss-vfs-3.0.0.CR5.jar:src/lib/slf4j-api-1.6.1.jar:src/lib/slf4j-simple-1.6.1.jar:src/lib/xml-apis-1.0.b2.jar

#all: classes javadocs tarfile jarfile
all: classes tarfile jarfile

classes: $(SOURCES) Makefile
#We need to tell java compiler where to put the package hierarchy (current directory)
	javac -cp $(CLASSPATH) $(SOURCES)
	@echo 'To run do "java com.jimweller.cpuscheduler.MainApp" or "make run"'

#javadocs: classes dirs
	#javadoc -private -version -author -d bin/javadocs/ *.java > bin/javadocs/javadoc.log 2>&1

#dirs: 
	#mkdir -p bin/javadocs

jarfile:
	mkdir -p $(PACKAGE_DIR)
	cp -a *.class pics $(PACKAGE_DIR)
	jar	cfm bin/cpu.jar manifest.txt com 

#tarfile:
	#cd bin; tar -czf ../cpu.tar.gz *;mv bin/cpu.tar.gz .

tarfile:
	tar pvczf ../cpu.tar.gz -C .. $(shell basename `pwd`)

clean:
	rm -rf $(PACKAGE_DIR)/*.class
	rm -rf *.class bin/cpu.jar bin/cpu.tar.gz bin/javadocs/*
	#mv bin/javadocs/CVS bin/javadocs/.CVS
	#mv bin/javadocs/.CVS bin/javadocs/CVS

run:
	java -cp $(CLASSPATH) com.jimweller.cpuscheduler.MainApp
