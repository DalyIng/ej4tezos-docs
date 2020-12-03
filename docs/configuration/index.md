# Maven Configuration:

<font size="+1">In order to use EJ4Tezos in your Maven project, you'll need to configure your settings.xml file by adding a new `profile`, below an example of settings.xml configuration, by default that file is under the `/.m2` folder.</font>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <pluginGroups/>
  <proxies/>
  <servers />
  <mirrors/>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots />
          <id>snapshots</id>
          <name>libs-snapshot</name>
          <url>http://artifactory.ej4tezos.org/artifactory/libs-snapshot</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>ej4tezos.repository.snapshots</id>
          <name>EJ4Tezos - Plugin Repository - Snapshots</name>
          <url>https://artifactory.ej4tezos.org/artifactory/libs-snapshot</url>
          <layout>default</layout>
          <releases>
            <enabled>false</enabled>
            <updatePolicy>never</updatePolicy>
            <checksumPolicy>warn</checksumPolicy>
          </releases>
          <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
            <checksumPolicy>fail</checksumPolicy>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
      <id>artifactory</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>artifactory</activeProfile>
  </activeProfiles>
</settings>
```