# Invoke entrypoints:

1. All smart contract entrypoints are named identically to their Michelson methods, taking the same parameter values.
2. Any successfull invokaction will return a transaction hash.
3. We have the choice to choose between a `Synchronous` and `Asynchronous` modes:
   - `Synchronous mode`: this mode is enabled by default, the transaction hash will be returned after a successful insertion of the transaction in a block.
   - `Asynchronous mode`: by choosing this mode, the transaction hash will be returned instantly after a successful injection

### Parameters:

1. `Contract's address`
2. `Node URL`

#### In the following example:

- We will invoke the `mint` entrypoint of the EuroTz smart contract.

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

            // Display the contract address:
            LOG.info("Token contract address: {}", token.getContractAddress());

            // Invoke the mint method:
            TezosTransactionHash transactionHash = token.mint(toTezosPublicAddress("tz1MwD9RhFGD8DN5PmBg3aKJPcVr5AoF8LmX"), BigInteger.valueOf(10000));
            LOG.info("Transaction hash: {}", transactionHash);

        }

        catch (Exception ex) {
            LOG.warn("An exception occurred: {}", ex.getMessage(), ex);
        }
    }

```

### Steps

1. Create a `Context` by passing the `node URL`
2. Create `contract proxy` by passing:
    - `Context` created in the above step;
    - `Contract address`;
    - `Signer Private Key`: the private key of injector and gas payer of the invokation;
    - `Mode`: Need to be passed as a param only if we want to choose the `Asynchronous Mode`, in our example we didn't pass this param, so we'll work with the default mode, the `Synchronous Mode`.
3. Invoke the `mint` entrypoint by passing the needed parameters: `receiver's address` and the `amount`.    

> The invokation GasLimit and StorageLimit are calculated dynamically based on an offChain simulation.

To invoke the `mint` entryPoint, type the following command in a terminal:

```bash
mvn -DORIGINATOR_PRIVATE_KEY=edskS3eyP77mJHL9tpLYRDCVfbkutRyc24Ja5Xaw2UffqqeGRBg5oEfYS9kpHWNGgarGJb2wbunCrZismFhvJe9ceEMeVNCZu6 clean install
```
