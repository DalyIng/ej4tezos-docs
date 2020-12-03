# Java Maven Plugin:

EJ4Tezos supports the generation of smart contract function wrappers in Java, the maven plugin is used to create java classes based on the JSON Micheline contract code.

The base configuration for the plugin will take the tezos _contract address_ and the _network_ the contract was deployed on in the `pom.xml`.

In the following guides, we'll take the [Euro.Tz](https://better-call.dev/carthagenet/KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z/operations) **which is an FA1.2** contract as a reference example:

In order to generate the Java stubs based on the contract's Micheline code, the `Java Maven Plugin` need the following parameters:

- `Network`: The network on which the contract was deployed.
- `Contract's name`: You contract's name (Optional).
- `Contract's address`: Contract address (KT1...)

In our case, the parameters needed are the following:

- `Network: carthagenet`
- `Contract's address: KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z`
- `Contract's name: EuroTz`

Now, to generate Java classes based on these contract's JSON Micheline code we need to configure our `pom.xml` file as following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.ej4tezos</groupId>
    <artifactId>java-se.parent</artifactId>
    <version>1.0.0.0-SNAPSHOT</version>
  </parent>
  <groupId>org.ej4tezos</groupId>
  <artifactId>contract.fa12</artifactId>
  <version>1.0.0.0-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>org.ej4tezos</groupId>
      <artifactId>java-se.proxy</artifactId>
      <version>1.0.0.0-SNAPSHOT</version>
    </dependency>
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
              <!-- Network -->
              <network>carthagenet</network>
              <!-- - - - - -->

              <!-- Contract's address -->
              <address>KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z</address>
              <!-- - - - - - - - - - -->
            </configuration>
          </execution>
          <execution>
            <id>micheline</id>
            <goals>
              <goal>micheline</goal>
            </goals>
            <configuration>

              <!-- Contract's name -->
              <name>EuroTz</name>
              <!-- - - - - - - - - -->

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
</project>

```

In the `Java Maven Plugin` three parts need to be executed to generate the contract's Java classes:

1. `Script` Execution: Grab the contract's JSON Micheline code based on the `network` and the `address` passed as parameters.

2. `Micheline` Execution: Generate the `Tezos Contract Definition (TCD)` which is a simpler definition format of the contract's entryPoints and storage.

3. `Java` Execution: Generate Java classes based on the `TCD` ganarted in the above execution.

> Note here that the dependencies added in the `<dependencies />` abdove are mandatory since the generated Java classes will depend on them.

To run the plugin, execute the goal `install`, in a terminal, under the project, run:

`mvn clean install`

You find the generated java classes inside the directory `target/classes/org/ej4tezos/contract`.

> The generated classes are "jarred", the jar needs to be added as dependency in the project that will interact with the smart contract. As a next step, we will interact with the smart contract, by invoking it's entrypoints and reading it's storage.

> You can find more details in the sample project [here](https://gitlab.com/tezos-paris-hub/ej4tezos/standard-contracts/ej4tezos-contract-fa1.2)
