# Java Maven Plugin:

EJ4Tezos supports the auto-generation of smart contract function wrappers in Java, the maven plugin is used to create java classes based on the JSON Micheline contract code.

The base configuration for the plugin will take the tezos contract address and the network the contract is deployed on in the pom.xml.

We'll take the [Euro.Tz](https://better-call.dev/carthagenet/KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z/operations) contract as example in the following tutorial:

We need the following parameters:

- `Network`
- `Contract's name`
- `Contract's address`

In our case, our parameters are the following:

- `carthagenet`
- `KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z`
- `EuroTz`

Now, In order to generate Java stubs of these contract we need to configure our `pom.xml` file as following:

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
              <!-- Contract's address -->
              <address>KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z</address>
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

Note here that the dependencies are mandatory since the generated Java classes will depend on those jars.

To run the plugin, execute the goal `install`, in a terminal, under the project, run:

`mvn clean install`

You find the generated java classes inside the directory `target/classes/org/ej4tezos/contract`.

The generated classes are "jarred", the jar will added as dependency in the project that will interact with the smart contract, so as a next step, we will interact with the smart contract, by invoking it's entrypoints and reading it's storage.
