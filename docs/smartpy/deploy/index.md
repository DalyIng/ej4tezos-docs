### DEPLOY

To Execute Compile goal, the following parameters are required:

1. **network**: Tezos network (*Mainnet* by default);
2. **name**: Name of file of your contract (must be the same used in the Compile goal);
3. **originatorPrivateKey**: PrivateKey of the originator. 

Example:
```xml
 <execution>
	 <id>compile</id>
	 <phase>initialize</phase>
	 <goals>
		 <goal>deploy</goal>
	 </goals>
	 <configuration>
		 <network>carthagenet</network>
		 <name>EuroTz</name>
		 <originatorPrivateKey>
			 ${ORIGINATOR_PRIVATE_KEY}
		 </originatorPrivateKey>
	 </configuration>
 </execution>
```