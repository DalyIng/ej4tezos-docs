# Apache Camel Component

## A sample using Twitter-Timeline

Apache Camel provides many readily available components (see [here](https://camel.apache.org/components/latest/index.html)). Among those components, there is one allowing the use of Camel routes to interact with Twitter.

In our sample (available [here](https://gitlab.com/tezos-paris-hub/ej4tezos/tezos-camel-component/ej4tezos-camel-twitter)), we will tweet some information each time a new block is added to the Tezos Mainnet.

First, we need to specify the source in the **RouteBuilder** class. For that purpose, we will use the **_Tezos_** Apache Camel component by simply writing a URI defining the component _Tezos_, the logical network that we want to listen to (i.e. *mainnet* which is defined as a bean of type **TezosConnectivity**) and what we want to get from the network (i.e. _block_(s) in our case):

```
from("tezos://mainnet/block")
```

The Tezos component supports more source type and can react to finer grained events happening on the chain. For example, the following **from** clause shows how to react to a transaction happening on a specific method (**mint** in this case) of a particuler contract:

```
from("tezos://mainnet/contract/KT1Acfs1M5FXHGYQpvdKUwGbZtrUkqrisweJ/mint")
```

Then we specify the target which is the Twitter-Timeline component provided by Apache Camel for Twitter. In order to proceed with a status update
( _tweeting_ ), we simply reference the component with the various Twitter profile credentials related to the account we want to use:

```
        from("tezos://mainnet/block").id("BlockRoute")
            .log(LoggingLevel.INFO, "Headers = ${headers} - Body = ${body}")
            .to("twitter-timeline://user" + getTwitterCredentials());
        ;
```

And TADAAAH! it works:

<p align="center">
<img src="./assets/twitterPost.png" alt="Twitter Post"/>
</p>

You can find more documentation about Apache Camel Twitter-Timeline [here](https://camel.apache.org/components/2.x/twitter-timeline-component.html)
