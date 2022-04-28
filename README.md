# Expression Language Injection Demo
RCE via EL injection in OGNL and struct2.
This is a demo I used in a sharing about Expression Langugae Injection. It is made by tweaking the showcase of struct2 version 2.3.30.

## About EL
EL is a feature in Java webapp libraries or frameworks. It allows developers to access data in a less cumbersome syntax. For example,
Java code: ```<%=HTMLEncoder.encode(((Person)person).getAddress().getStreet()) %>```
EL: ```${person.address.street}``` 
Both version does the same thing, but EL is way easier to use.

Other than accessing data, EL can also 
- access objects (Javabeans and Implicit Objects)
- run functions
- perform operations

When user controllable data are interpreted by EL interpreter, it can often give user to much power. With a malicious payload, users can leak, tamper data or even perform RCE. A basic RCE payload would look like this 
```#{"".getClass().forName("java.lang.Runtime").getRuntime().exec("curl http://127.0.0.1:8000")}```

Luckily, mordern frameworks impements defence mechanism that helps block these attacks. They would limit the access of ELs. Yet we should not assume that these defences are absolute, the below demo would show how a past version of struct2 defense could be bypassed. Therefore it is important to sanitize usesr's input and avoid letting them into EL interpreter.

## The Exploit (The Spoilers)
See [this](https://www.contrastsecurity.com/security-influencers/cve-2018-11776) for the payload.
See [this](https://pentest-tools.com/blog/exploiting-ognl-injection-in-apache-struts#8_Understanding_OGNL_injection_payloads) for the rationale behind.

## Setup
To run this demo, 
1. Download the latest Apache Tomcat at [here](https://tomcat.apache.org/download-90.cgi)
2. Extract the binary to /var
3. cd to the bin in Tomcat
4. Set scripts as executable
    ```sudo chmod +x *.sh ```
5. Start up Tomcat
    ```./startup.sh```
6. Go to http://localhost:8080/ to see if it is running
7. Clone this repo
    ```git clone https://github.com/NavyNavi/EL-Injection-Demo```
8. Deploy this webapp
    ```sudo cp target/struts2-rest-showcase.war /var/tomcat/webapps``` 
9. The demo is at http://localhost:8080/struts2-rest-showcase/

#### Build Webapp
To recompile the application after changing the code, go to the root directory of this project.
1. ```java --version```
    Make sure to use java 11.
2. Check if maven is installed.
    ```mvn -v```
3. If maven is not installed
    ```sudo apt install maven```
4. Then compile the app.
    ```mvn package```
5. Deploy the app. See **Setup** step 8.

## Reference
https://pentest-tools.com/blog/exploiting-ognl-injection-in-apache-struts#struts-example
https://www.contrastsecurity.com/security-influencers/cve-2018-11776