# Interacting with Smart Contracts:

### Project configuration:

> For a coherence goal, we will continue using the **FA1.2** `EuroTz` contract as a reference as in the previous part.

To use use the generated Java classes in a project that aims to interact with the a smart contract, we need to import the jar generated via the `Java maven plugin` as a dependency.

`pom.xml`:

```xml
  <parent>
    <groupId>org.ej4tezos</groupId>
    <artifactId>java-se.parent</artifactId>
    <version>1.0.0.0-SNAPSHOT</version>
  </parent>
  <groupId>org.ej4tezos</groupId>
  <artifactId>contract.sample</artifactId>
  <version>1.0.0.0-SNAPSHOT</version>
  <dependencies>
    <!-- generated JAR as dependency-->
    <dependency>
      <groupId>org.ej4tezos</groupId>
      <artifactId>contract.fa12</artifactId>
      <version>1.0.0.0-SNAPSHOT</version>
    </dependency>
    <!-- - - - - - - - - - - - - -  -->
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
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-simple</artifactId>
      <version>${slf4j.version}</version>
    </dependency>
  </dependencies>
```
