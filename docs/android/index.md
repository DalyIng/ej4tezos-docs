# Android

In the following tutorial, we will create an Android app in order to:
- Interact with the EuroTz smart contract using the generated Java stubs in the Java Maven Plugin section.
- Generate a new Tezos identity (valid public and private address).

Create a new blank android application and **choose an Android API > 24**.

## Configuration:

Add artifactory url in the root `build.gradle` file as following:

```groovy
maven {
        url 'http://artifactory.ej4tezos.org/artifactory/libs-snapshot'
}
```

Add EJ4Tezos dependencies in the `/app/build.gradle` file as following:

```groovy
dependencies {
    ...
    //
    implementation 'org.ej4tezos:contract.fa12:1.0.0.0-SNAPSHOT'
    implementation 'org.ej4tezos:java-se.proxy:1.0.0.0-SNAPSHOT'
    //
    ...
}

```

Add the following `packagingOptions` in the same file as following in order to resolve *more than one file was found with OS independent path* issue.

```groovy
packagingOptions {
        exclude 'OSGI-OPT/src/org/osgi/service/condpermadmin/packageinfo'
        exclude 'javax/annotation/CheckReturnValue.java'
        exclude 'org/apache/commons/codec/language/bm/gen_rules_dutch.txt'
        exclude 'org/apache/commons/codec/language/bm/gen_approx_greeklatin.txt'
        exclude 'OSGI-OPT/src/org/osgi/framework/namespace/HostNamespace.java'
        exclude 'OSGI-OPT/src/org/osgi/framework/hooks/resolver/ResolverHookFactory.java'
        exclude 'META-INF/DEPENDENCIES'
        exclude 'mozilla/public-suffix-list.txt'
        exclude 'lib/x86_64/darwin/libscrypt.dylib'
        exclude 'lib/x86_64/freebsd/libscrypt.so'
        exclude 'lib/x86_64/linux/libscrypt.so'
    }

```

## Invoke entryPoints:

Same configuration as in *Interacting with Smart Contracts* is needed here, more details in the [sample android project](https://gitlab.com/tezos-paris-hub/ej4tezos/android-connectivity/ej4tezos-android-app-sample/-/blob/master/app/src/main/java/org/ej4tezos/ej4tezosandroidsample/SampleFragment.java) under the `private class Mint`.

## Generate Key pair:

In order to generate a new key pair, we need to follow the example below:

```java
public void generateKeysTest () throws Exception {

        TezosCryptoProviderImpl tezosCryptoProvider = new TezosCryptoProviderImpl();

        tezosCryptoProvider.setSecureRandom(new MySecureRandom(
                new int [] {
                        135, 233,  35, 106,
                        34, 131, 105, 112,
                        16, 180,  42,   0,
                        181, 106, 247, 150,
                        209, 248, 169, 174,
                        5, 255,   9, 173,
                        46, 128, 233, 144,
                        61,  85, 190,   4
                }
        ));

        tezosCryptoProvider.init();

        TezosKeyService tezosKeyService = new TezosKeyServiceImpl();

        ((TezosKeyServiceImpl) tezosKeyService).setTezosCryptoProvider(tezosCryptoProvider);
        ((TezosKeyServiceImpl) tezosKeyService).init();

        TezosIdentity identity = tezosKeyService.generateIdentity();

        System.out.println("----------------------------------------");
        System.out.println("private key: " + identity.getPrivateKey().getValue());
        System.out.println("public key: " + identity.getPublicKey().getValue());
        System.out.println("public address: " + identity.getPublicAddress().getValue());
        System.out.println("----------------------------------------");

    }

```










