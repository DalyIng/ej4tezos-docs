# :page_with_curl: SmartPy Plugin


## :wave: Intro

#### The _SmartPy Maven Plugin_ provides a Maven plugin which can generate compile and deploy SmartPy smart contracts to Tezos.

## :bell: Dependencies

The SmartPy Plugin depends on  [**python3**](https://www.python.org/downloads/),  [**node.js** ](https://nodejs.org/en/download/) and **smartpy-cli**.

To install the SmartPy-Cli: https://smartpy.io/cli/

## 💡 Goals

In the following paragraph, the various goals are described in more details.

We will be using the [EuroTz Smart Contract](shorturl.at/ehnvH) as an example. Note that it's storage must be initialized with the contract's admin address.

### POM.XML

The POM must contain the SmartPy plugin in the build as the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>  
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">  <modelVersion>4.0.0</modelVersion>  
<groupId>your.group.id</groupId>  
<artifactId>your.artifact.id</artifactId>  
<version>your.version</version>  
	<build>  
		 <plugins>
			  <plugin> 
			  <groupId>org.ej4tezos</groupId>  
		      <artifactId>smartpy-maven-plugin</artifactId>  
			  <version>1.0.0.0-SNAPSHOT</version>  
			  <executions> 
				  <!-- COMPILE: details below -->
				  <!-- DEPLOY: details below -->
			 </executions> 
			 </plugin> 
		 </plugins> 
	 </build>
 </project>
```

### :rocket: SAMPLE

You can find the Sample described above [here](https://gitlab.com/tezos-paris-hub/ej4tezos/smartpy-maven-plugin/ej4tezos-smartpy-eurotz-sample).

If you installed the dependencies and configure your settings.xml as described [here](https://gitlab.com/tezos-paris-hub/ej4tezos/ej4tezos-tutorial) , you are ready :fire:, you can run the sample by executing the following command in your terminal under the project folder:

```sh
mvn -DORIGINATOR_PRIVATE_KEY=edsk.... clean install
```