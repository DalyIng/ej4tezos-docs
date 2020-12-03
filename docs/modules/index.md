## Modules:

### Java SE Connectivity:

The *Java SE Connectivity* provides the basic low-level connectivity tooling for Tezos besides some utilities libraries that are shared with the other modules of the library.

A sample project showing how the library can be used to invoked a FA1.2 token can be found [here](https://gitlab.com/tezos-paris-hub/ej4tezos/java-se-connectivity/ej4tezos-jse-sample-fa12).

### Java Maven Plugin:

The *Java Maven Plugin* provides a Maven plugin which can generate *Java* code stubs to representing proxies to deployed Tezos smart contracts. The plugin is able to retrieve the contract description, transform it to a simpler definition format to finally feed a *Java* code generator. 

A sample project showing how the plugin can be used to generate proxy code to invoke the Euro.Tz smart contract can be found [here](https://gitlab.com/tezos-paris-hub/ej4tezos/maven-code-generator-plugin/ej4tezos-cgp-sample).

### SmartPy Maven Plugin:

The *SmartPy Maven Plugin* provides a Maven plugin which can generate compile and deploy SmartPy smart contracts to Tezos.

A sample project showing how the plugin can be used to compile and deploy a smart contract can be found [here](https://gitlab.com/tezos-paris-hub/ej4tezos/smartpy-maven-plugin/ej4tezos-smartpy-sample).

### Android Connectivity:

The *Android Connectivity* has been achieved by making sure that the *Java SE Connectivity* module would support Android out-of-the box. A sample project showing how to integrate *EJ4Tezos* in a plain Android application can be found [here](https://gitlab.com/tezos-paris-hub/ej4tezos/android-connectivity/ej4tezos-android-app-sample).

### Tezos Camel Component:

The *Tezos Camel Component* allows the use of Tezos within the *Apache Camel* Enterprice Integration Framework. 

Here are the references of several sample projects using the *Tezos Camel Component*:

- An example showing how to broadcast Tezos information on [Twitter](https://gitlab.com/tezos-paris-hub/ej4tezos/tezos-camel-component/ej4tezos-camel-twitter).
- An example showing the various syntax of the Tezos [endpoint](https://gitlab.com/tezos-paris-hub/ej4tezos/tezos-camel-component/ej4tezos-camel-sample).
- An example showing how to store Tezos Json based message directly as Document in [MongoDB](https://gitlab.com/tezos-paris-hub/ej4tezos/tezos-camel-component/ej4tezos-camel-sample-indexer).