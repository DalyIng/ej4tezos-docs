# Working with SmartPy contracts using EJ4Tezos

In this chapter, we will take some time to see how a Java application can interact with a Tezos Smart Contract via EJ4Tezos.

## Setting Up the Environment

Before starting, you must make sure you have `Maven`, `Node.js` and `Python3` installed on your computer. If you have you are ready to:

- Add _EJ4Tezos_ in your `settings` following the configuration [here](./configuration/index);
- Install the SmartPy cli, to do so, please follow the instructions [here](https://smartpy.io/cli/).

## Smart Contract Code

In order to make this tutorial as simple as we can, we'll develop a simple smart contract that contains:

- Two entryPoints: `increment` & `decrement`
- Two storage fields: `administrator` & `storedValue`

Here's our contract:

```python
import smartpy as sp

class EJ4TezosTutorial(sp.Contract):
    def __init__(self, admin, value):
        self.init(storedValue = value, administrator = admin)

    @sp.entry_point
    def increment(self, value):
        self.data.storedValue += value

    @sp.entry_point
    def decrement(self, value):
        self.data.storedValue -= value

if "templates" not in __name__:
    @sp.add_test(name = "EJ4TezosTutorial")
    def test():
        ej4tezosTutorial = EJ4TezosTutorial(sp.address("tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW"), 0)
        scenario = sp.test_scenario()
        scenario.h1("EJ4Tezos Tutorial")
        scenario += ej4tezosTutorial
        scenario += ej4tezosTutorial.increment(15)
        scenario.verify(ej4tezosTutorial.data.storedValue == 15)
        scenario += ej4tezosTutorial.decrement(6)
        scenario.verify(ej4tezosTutorial.data.storedValue == 9)
```

## Compile and Deploy the Smart contract using EJ4Tezos SmartPy Plugin

- Create a first `Maven` project from a `terminal` by typing the following commands:

```bash
> mvn archetype:generate -DgroupId=org.ej4tezos -DartifactId=smartpy-tutorial-smartpy -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
> cd smartpy-tutorial-smartpy
```

This will generate a new `maven` project.

Now, under `smartpy-tutorial-smartpy/src/main/java/org/ej4tezos`:

- Remove the `App.java`;
- Create a new folder and name it `smartpy` under `src/main`;
- Create a new file and name it **EJ4TezosTutorial** (Same name of the contract's class in the python code);
- Paste the Smart contract's code.

### Compile

As specified in the [SmartPy Compile part](./smartpy/compile/index), we need to provide the `compile` job the following parameters:

1. _compiler_: Compiler Path;
2. _name_: Name of file of your contract;
3. _classCall_: Name of Contract Class followed by the the storage initialization, same used to compile a SmartPy contract via SmartPy CLI.

So, in the current context, those parameters take as values:

1. `SmartPy compiler path` (In my machine the path is: `/var/smartpy-cli/SmartPy.sh`)
2. `EJ4TezosTutorial`
3. `EJ4TezosTutorial(0, sp.address("tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW"))`: We initialsed the storage as following:
   - `storeValue`: _0_
   - `administrator`: _tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW`_

### Deploy

As specified in the [SmartPy Deploy part](./smartpy/deploy/index), we need to provide the `deploy` job the following parameters:

1. _network_: Tezos network (Mainnet by default);
2. _name_: Name of file of your contract (must be the same used in the Compile goal);
3. _originatorPrivateKey_: PrivateKey of the originator.

So, in the current context, those parameters take as values:

1. `carthagenet`
2. `EJ4TezosTutorial`
3. `${ORIGINATOR_PRIVATE_KEY}`: these parameter will be passed in the terminal when building the project.

### POM.xml

Now we need to add the following `xml` in our `pom.xml` file.

```xml
<!-- ....... -->
<build>
	<plugins>
		<plugin>
			<groupId>org.ej4tezos</groupId>
			<artifactId>smartpy-maven-plugin</artifactId>
			<version>1.0.0.0-SNAPSHOT</version>
			<executions>
				<execution>
					<id>compile</id>
					<phase>validate</phase>
					<goals>
						<goal>compile</goal>
					</goals>
					<configuration>
						<compiler>/var/smartpy-cli/SmartPy.sh</compiler>
						<name>EJ4TezosTutorial</name>
						<classCall>EJ4TezosTutorial(sp.address("tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW"), 0)</classCall>
					</configuration>
				</execution>
				<execution>
					<id>deploy</id>
					<phase>initialize</phase>
					<goals>
						<goal>deploy</goal>
					</goals>
					<configuration>
						<network>carthagenet</network>
						<name>EJ4TezosTutorial</name>
						<originatorPrivateKey>${ORIGINATOR_PRIVATE_KEY}</originatorPrivateKey>
					</configuration>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>
<!-- ....... -->
```

### Build the project

By typing the following command in a terminal we build the project:

```bash
 mvn -DORIGINATOR_PRIVATE_KEY=<YOUR PRIVATE KEY edsk..> clean install
```

A successful build will generate under

1.  `/target/compile`: Michelson compiled code;
2.  `/target/deploy`: the `deploymentDescriptor.json` a file thagt contains all the origination details, just like the following:

Here's the `deploymentDescriptor.json` when I built the project:

```json
{
  "originationTransactionHash": "onnMMnktm8jgwrWgS1mKJQ4qZ8S4gi5DrmeCghRaxhuT2s5Mw4Q",
  "host": "YOUR_HOST_DETAILS",
  "originatedContractAddress": "KT19sEbnhft9STCTk1hqvojw4YHLMxALYwCi",
  "user": "YOUR_USERNAME",
  "network": "testnet",
  "timestamp": "2020-12-04 15:27:17.013"
}
```

And YEAH! that's it! Compiling and deploying SmartPy contracts is very simple with `EJ4Tezos`.

## Generate Java classes using EJ4Tezos Java Plugin

- Create a second `Maven` project from a `terminal` by typing the following commands:

```bash
> mvn archetype:generate -DgroupId=org.ej4tezos -DartifactId=smartpy-tutorial-java -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
> cd smartpy-tutorial-java
```

Now, under `smartpy-tutorial-java/src/main/java/org/ej4tezos`:

- Remove `src` folder.

As specified in the [Java Maven Plugin part](./java/index), we need to provide the following parameters to our plugin:

- _Network_: The network on which the contract was deployed;
- _Contract's name_: You contract's name (Optional);
- _Contract's address_: Contract address (KT1...).

In the current context, those parameters take as values:

- `carthagenet`
- `KT1W34Wdfafv5mmT8mYWGNFj91W8dAfArYyp` (originated contract's address in the provious part)
- `EJ4TezosTutorial`

Now we need to add the following `xml` in our `pom.xml` file.

```xml
<!-- ....... -->
<parent>
    <groupId>org.ej4tezos</groupId>
    <artifactId>java-se.parent</artifactId>
    <version>1.0.0.0-SNAPSHOT</version>
</parent>
<!-- ....... -->
<dependencies>
	<dependencies>
        <dependency>
            <groupId>org.ej4tezos</groupId>
            <artifactId>java-se.proxy</artifactId>
            <version>1.0.0.0-SNAPSHOT</version>
        </dependency>
    </dependencies>
</dependencies>
<build>
	<plugins>
		<plugin>
			<groupId>org.ej4tezos</groupId>
			<artifactId>cgp-maven-plugin</artifactId>
			<version>1.0.0.0-SNAPSHOT</version>
			<executions>
				<execution>
					<id>script</id>
					<goals>
						<goal>script</goal>
					</goals>
					<configuration>
                        <!-- Network param -->
						<network>carthagenet</network>
                        <!-- Contract's address param -->
						<address>KT1W34Wdfafv5mmT8mYWGNFj91W8dAfArYyp</address>
					</configuration>
				</execution>
				<execution>
					<id>micheline</id>
					<goals>
						<goal>micheline</goal>
					</goals>
					<configuration>
                        <!-- Contract's name -->
						<name>EJ4TezosTutorial</name>
					</configuration>
				</execution>
				<execution>
					<id>java</id>
					<phase>process-resources</phase>
					<goals>
						<goal>java</goal>
					</goals>
				</execution>
			</executions>
		</plugin>
		<plugin>
			<groupId>org.codehaus.mojo</groupId>
			<artifactId>build-helper-maven-plugin</artifactId>
			<version>1.7</version>
			<executions>
				<execution>
					<id>add-source</id>
					<phase>process-sources</phase>
					<goals>
						<goal>add-source</goal>
					</goals>
					<configuration>
						<sources>
							<source>target/generated-sources/ej4tezos</source>
						</sources>
					</configuration>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>
<!-- ....... -->
```

To run the plugin, execute the goal install, in a terminal, under the project, run:

```bash
mvn clean install
```

You find the generated java classes inside the directory target/classes/org/ej4tezos/contract.

## Intercat with the Smart Contract

- Create a second `Maven` project from a `terminal` by typing the following commands:

```bash
> mvn archetype:generate -DgroupId=org.ej4tezos -DartifactId=smartpy-tutorial-interact -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
> cd smartpy-tutorial-interact
```

Add the following `xml` in the `pom.xml`:

```xml
<dependencies>
	<dependency>
        <!-- Generated project in the previous part -->
		<groupId>org.ej4tezos</groupId>
		<artifactId>smartpy-tutorial-java</artifactId>
		<version>1.0-SNAPSHOT</version>
        <!-- - - - - - - - - - - - -  - - - - - - - -->
	</dependency>
	<dependency>
		<groupId>org.ej4tezos</groupId>
		<artifactId>java-se.proxy</artifactId>
		<version>1.0.0.0-SNAPSHOT</version>
	</dependency>
	<dependency>
		<groupId>org.ej4tezos</groupId>
		<artifactId>java-se.default-impl</artifactId>
		<version>1.0.0.0-SNAPSHOT</version>
	</dependency>
</dependencies>
```

Paste the following code in `App.java` under `smartpy-tutorial-interact/src/main/java/org/ej4tezos` by the following:

```java
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
package org.ej4tezos;

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
import java.math.BigInteger;

import org.ej4tezos.model.TezosPrivateKey;
import org.ej4tezos.model.TezosContractAddress;

import org.ej4tezos.api.TezosContractStorage.Mode;

import org.ej4tezos.api.model.TezosTransactionHash;

import org.ej4tezos.papi.TezosContractProxyFactoryContext;

import org.ej4tezos.proxy.TezosContractProxyFactoryContextImpl;

import static org.ej4tezos.model.TezosPrivateKey.toTezosPrivateKey;
import static org.ej4tezos.model.TezosContractAddress.toTezosContractAddress;

import org.ej4tezos.contract.EJ4TezosTutorial;
import org.ej4tezos.contract.EJ4TezosTutorialStorage;

import static org.ej4tezos.contract.EJ4TezosTutorialHelper.createProxy;
import static org.ej4tezos.contract.EJ4TezosTutorialHelper.createStorageProxy;

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
/**
 * @author Mohamed Ali Masmoudi (mohammedali.masmoudi@gmail.com)
 */
public class App {

    private static Logger LOG = LoggerFactory.getLogger(App.class);

    public static void main (String [] args) {

        try {

            if(args.length < 1) {
                System.out.println("Please specify the private key!");
                return;
            }

            //
            TezosPrivateKey callerPrivateKey = toTezosPrivateKey(args[0]);
            TezosContractAddress tezosContractAddress = toTezosContractAddress("KT19sEbnhft9STCTk1hqvojw4YHLMxALYwCi");

            //
            TezosContractProxyFactoryContext context
                    = new TezosContractProxyFactoryContextImpl("https://testnet-tezos.giganode.io");

            // Create the proxies:
            EJ4TezosTutorial ej4tezosTutorial = createProxy(context, tezosContractAddress, callerPrivateKey);
            EJ4TezosTutorialStorage ej4tezosTutorialStorage = createStorageProxy(context, tezosContractAddress, Mode.REAL_TIME);

            // Display the contract address:
            System.out.println("Token contract address    :" + ej4tezosTutorial.getContractAddress());

            // Display the storedValue value before invocation
            System.out.println("storedValue from storage before invocation    :" + ej4tezosTutorialStorage.getStoredValue());

            // Display the administrator address:
            System.out.println("administrator from storage    :" + ej4tezosTutorialStorage.getAdministrator());

            // Invoke the increment method:
            TezosTransactionHash transactionHash = ej4tezosTutorial.increment(BigInteger.valueOf(100));

            System.out.println("Transaction hash:       " + transactionHash);

            // Display the storedValue value after invocation
            System.out.println("storedValue from storage after invocation    :" + ej4tezosTutorialStorage.getStoredValue());

        }

        catch (Exception ex) {
            System.out.println("An exception occurred: " + ex.getMessage() + " " + ex);
        }
    }

    @Override
    public String toString () {
        return "Main";
    }
}


```

Run the `main` method by typing in a terminal:

```bash
mvn compile exec:java -Dexec.mainClass="org.ej4tezos.App" -Dexec.args="edsk..."

```

And here the result:

```bash
Token contract address    :KT19sEbnhft9STCTk1hqvojw4YHLMxALYwCi
storedValue from storage before invocation    :0
administrator from storage    :tz1djN1zPWUYpanMS1YhKJ2EmFSYs6qjf4bW
Transaction hash:       ooTjVDEANFoNcPCaFEHaBWszV4uCQeMAv3hwfGSYDcxEqs4dfED
storedValue from storage after invocation    :100
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

See the call operation to the `increment` entryPoint details [here](https://better-call.dev/carthagenet/opg/op8TKbTTaW2BtLEh9wTEDFeiYFdXHm8HLHJkBnCxAPNCLKstRYD/contents)

AND THAT'S IT!
