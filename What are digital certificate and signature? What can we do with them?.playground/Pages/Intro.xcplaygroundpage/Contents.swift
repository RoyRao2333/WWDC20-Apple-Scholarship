/*:
 ## An Introduction Of Digital Signature And Digital Certificate
 ___
 Welcome to this brief but vivid introduction of __Digital Signature and Digital Certificate!__
 ___
 */
/*:
 ### Preposition
 ___
 * callout(Before we can get down to out business, you should know:):
 __Digital Signature and Digital Certificate__ are based on __RSA algorithm__ and __Hash__. __RSA algorithm__ is an asymmetric encryption algorithm proposed in 1977 by Ron Rivest, Adi Shamir, and Leonard Adleman. RSA algorithm is the first algorithm that can be used for both encryption and digital signature. It is also easy to understand and operate. RSA is also the most widely studied public key algorithm. As of 2017, it is generally regarded as one of the best public key schemes. __Hash__ is a function that transforms an input of any length into an output of a fixed length through __the Hash algorithm__. The Hash algorithm converts a data into a flag that is closely related to every byte of the source data. Another feature of Hash algorithms is that they are difficult to find reverse patterns. That is, we cannot infer the original text from the content after hash. At the same time, different text will result in different hash results.
 ___
 * callout(So what are Digital Signature and Digital Certificate anyway?):
 __Digital signature__ is a segment of digital string which can not be forged by others, it can also identify and prove the validity of digital information. __Digital certificates__ are issued by CA certificate authorization center, an authoritative electronic document that can provide authentication on the Internet.
 ___
 * callout(Why do we need them?):
 Nowadays, we are facing various kinds of security problems in our Internet world. We may lose a lot of money or get our devices crashed just because of some __UNCERTIFIED__ applications. Our secret messages may be intercepted by some people with ulterior motives. All these problems make our lives hard and we can do little about it. __Until we have Digital Signature and Digital Certificate!__
 ___
 */
/*:
 ### Perfect examples we're using:
 ___
 * callout(HTTPS):
 __HTTPS (Hypertext Transfer Protocol Secure)__ is a Secure HTTP channel, which is a Secure version of HTTP. Why do we need HTTPS? The reason is simple: HTTP is not secure. When we send relatively private data (such as your bank card and id card) to the server, we use HTTP to communicate, then security will not be guaranteed. On the basis of HTTP, the security of HTTPS transmission process is guaranteed by means of transmission encryption and identity authentication.
 ___
 * callout(Code Signing):
 __Code Signing__ is a security technique to verify if an App was created by you. Once an application is signed, the system can defend against any change in the application, whether the change is thought to be unintentional or malicious. Applications must be signed with an Apple-certified certificate before they can be installed on a device or posted to the App Store. We must also mention another technique: __Gatekeeper__. macOS includes a technology called Gatekeeper, which is meant to ensure that only trusted software runs on the Mac. When you install Mac applications, plug-ins, and installer software from outside the App Store, macOS checks the Developer ID signature and notarial status to verify that the software is from an approved Developer and has not been changed.
 ___
 */
/*:
 In this introduction, you'll know the functionalities of them and you'll also learn how we can use them!
 
 Can't wait? __Run the code and find out more!__
 */
import Cocoa
import PlaygroundSupport

let currentViewController = IntroViewController.init()
PlaygroundPage.current.liveView = currentViewController.view
/*:
 ___
### NEXT PAGE:
[Next](@next)
 ___
 */
