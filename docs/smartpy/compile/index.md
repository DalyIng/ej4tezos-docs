### COMPILE

To Execute Compile goal, the following parameters are required:

1. **compiler**: Compiler Path;
2. **name**: Name of file of your contract;
3. **classCall**: Name of Contract Class followed by the the storage initialization. 

Example:
```xml
 <execution>
	 <id>compile</id>
	 <phase>validate</phase>
	 <goals>
		 <goal>compile</goal>
	 </goals>
	 <configuration>
		 <compiler>/var/smartpy-cli/SmartPy.sh</compiler>
		 <name>EuroTz</name>
		 <classCall>
			EuroTz(sp.address("tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW"))
		 </classCall>
	 </configuration>
 </execution>
```
