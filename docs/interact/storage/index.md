# Reading from Storage:

### Parameters:

1. `Contract's address`
2. `Node URL`

#### In the following example:

- We will read the `totalSupply` of the EuroTz smart contact and it's `administrator` from it's storage.

```java
public static void main (String [] args) {

        try {

            // Contract's address
            TezosContractAddress tezosContractAddress = toTezosContractAddress("KT1GVGz2YwuscuN1MEtocf45Su4xomQj1K8z");

            // Create a context by passing the node URL
            TezosContractProxyFactoryContext context
                = new TezosContractProxyFactoryContextImpl("https://carthagenet.smartpy.io/");

            // Create a storage proxy proxies:
            FA12TokenStorage tokenStorage = createStorageProxy(context, tezosContractAddress);

            // Display the contract address:
            LOG.info("Token contract address: {}", token.getContractAddress());

            // Get the EuroTz total supply and display it
            LOG.info("Token total supply    : {}", tokenStorage.getTotalSupply());
            LOG.info("Administrator         : {}", tokenStorage.getAdministrator());

        }

        catch (Exception ex) {
            LOG.warn("An exception occurred: {}", ex.getMessage(), ex);
        }
    }

```

### Steps

1. Create a `Context` by passing the `node URL`
2. Create `storage contract proxy` by passing:

   - `Context` created in the above step;
   - `Contract address`;
   - `Mode`: Need to be passed as a param only if we want to choose the `RealTime Mode`, in our example we didn't pass this param, so we'll work with the default mode, the `Cached Mode`.

3. call a `getter` method of the entry need to be readed, in our case we have a `totalSupply` field in our contract's storage, to read it's value, simply call `getTotalSupply` method from the `storage proxy`, same for the `administrator` field, we can it's value by calllling `getAdministrator` method.

So, generally, if you have a field called `toto` in your contract's storage, accessing it's value can be done by calling `getToto()` method.

To display the values in the above example, type the following command in a terminal:

```bash
mvn clean install
```
