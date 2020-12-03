# Project configuration:

In order to use use the generated Java classes in the project which will interact with the deployed smart contract, we need to import the jar generated via the Java maven plugin as dependency.

We will continue using the same contract as in the previous part, the Euro.Tz contract.

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

# Invoking entrypoints and reading storage:

1. All smart contract entrypoints are named identically to their Michelson methods, taking the same parameter values.
2. Any successfull invokaction will return a transaction hash.
3. We have the choice to choose between a Synchronous and Asynchronous modes:
   - Synchronous mode: this mode is enabled by default, the transaction hash will be returned after a successfull insertion of the transaction in a block.
   - Asynchronous mode: by choosing this mode, the transaction hash will be returned instantly after the injection

### Parameters:

1. `Contract's address`
2. `Node URL`

#### In the following example:

- We will invoke the `mint` entrypoint of the EuroTz smart contract.
- We will read the `totalSupply` of the EuroTz smart contact from it's storage.

```java
public static void main (String [] args) {

        try {

            if(args.length < 1) {
                LOG.error("Please specify the private key!");
                return;
            }

            // Minter private key will be passed as an argument
            TezosPrivateKey adminPrivateKey = toTezosPrivateKey(args[0]);
            // Contract's address
            TezosContractAddress tezosContractAddress = toTezosContractAddress("KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z");

            // Create a context by passing the node URL
            TezosContractProxyFactoryContext context
                = new TezosContractProxyFactoryContextImpl("https://carthagenet.smartpy.io/");

            // Create the proxies:
            FA12Token token = createProxy(context, tezosContractAddress, adminPrivateKey);
            FA12TokenStorage tokenStorage = createStorageProxy(context, tezosContractAddress);

            // Display the contract address:
            LOG.info("Token contract address: {}", token.getContractAddress());

            // Get the EuroTz total supply and display it
            LOG.info("Token total supply    : {}", tokenStorage.getTotalSupply());

            // Invoke the mint method:
            TezosTransactionHash transactionHash = token.mint(toTezosPublicAddress("tz1MwD9RhFGD8DN5PmBg3aKJPcVr5AoF8LmX"), BigInteger.valueOf(10000));
            LOG.info("Transaction hash: {}", transactionHash);

        }

        catch (Exception ex) {
            LOG.warn("An exception occurred: {}", ex.getMessage(), ex);
        }
    }

```

- In the above example, we minted `10000 tokens` to the `tz1MwD9RhFGD8DN5PmBg3aKJPcVr5AoF8LmX` address;
- We choosed the Synchronous mode;
- We accessed the EuroTz storage and read the totalSupply value.


The invokation GasLimit and StorageLimit are calculated dynamically based on an offChain simulation.