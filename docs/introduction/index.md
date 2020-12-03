## Introduction:

<font size="+1">EJ4Tezos is a lightweight, highly modular, reactive, type safe Java and Android library for working with Smart Contracts and integrating with clients (nodes) on the Tezos network.</font>


<font size="+1">The EJ4Tezos project aims at providing a complete toolbox to ease the interaction between Java Enterprise applications and the Tezos blockchain. EJ4Tezos is leveraging various de-facto technologies from the Enterprise Java world such as Apache Maven and Apache Camel. EJ4Tezos is currently under heavy development.</font>

### Build infrastructure:

**EJ4Tezos** relies heavily on the Maven build tool to produce its various modules. Each project contains a POM file and is configured to be built by our dedidacted Jenkins server which can be found [here](https://jenkins.ej4tezos.org/). All the source repositories are located [here](https://gitlab.com/tezos-paris-hub/ej4tezos).

### Repositories configuration:

All the artifacts of **EJ4Tezos** are published on an Artifactory server located [here](https://artifactory.ej4tezos.org/). The server is following the Maven protocol and structure. 

Snapshots are accessible at the following URL:

```
https://artifactory.ej4tezos.org/artifactory/libs-snapshot
```

and releases at the following URL:


```
https://artifactory.ej4tezos.org/artifactory/libs-release
```