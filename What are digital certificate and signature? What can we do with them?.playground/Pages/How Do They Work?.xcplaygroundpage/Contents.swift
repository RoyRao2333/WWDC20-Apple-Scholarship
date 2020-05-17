//: ## How Do Digital Signature And Digital Certificate Work?
/*:
 ___
 > In this page, you'll learn how digital certificate and digital signature work and how to use it.
 Let's give it a try!
 ___
 */
/*:
 ### Digital Signature
 ___
 * callout(Why should we use Digital Signature?):
 Although we can encrypt our message using RSA Encryption Algorithm and no one else can decrypt your message unless you have the private key, we can not prevent this message from being tampered. In this way, Bob may receives the tampered information, which will be inconsistent with the information Susan intended to convey. Then how do we ensure the integrity of the information? Or how the receiver can identify it when the message is tampered? __Let's welcome Digital Signature!__
 ___
 * callout(How can we use it?):
 The key technology to guarantee our messages' integrity is __Hash__. First, we hash the message to be transferred to get a unique string of characters, usually called __digest__. Then we encrypt this digest with our private key. This ensures that only the public key we generated can correctly decrypt the digest, which means the digest must come from us. The encrypted digest is actually our digital signature. Finally, we attach the digital signature to the end of our original message, thus forming a complete message with a digital signature. When the receiver get the message, he can use our public key to decrypt the digest. Then he hash the original message and contrast with the digest. If they're exactly the same, then the original message is __not tampered with__.
 ___
 */
/*:
 ### Digital Certificate
 ___
 * callout(Why should we use Digital Certificate?):
 It seems that now, with the use of public and private keys and digital signatures, we can guarantee the privacy and integrity of the transmission of information. But there is still a problem, that is the issue of public key distribution. How can we be sure of distributing these keys to the right people? Let's say there's a middleman Carter out there, and he intercepted the public key that Bob sent to Alice. Then he forged a fake public key with Bob's name and sent it to Alice. This results in Pat actually communicating with the middleman, but thinking she is communicating with Bob. The question now is how can Alice be sure that the public key she receives is really Bob's and not someone else's fake one! __This is where Digital Certificate come in__.
 ___
 * callout(How can we use it?):
 We can actually make an analogy with real life problems. Each of us has a unique id card and when we are facing a stranger, we can usually check their id card. But what if the id card that gives us is a fake one? In reality, we tend to go to government agencies and verify its authenticity. So, similarly, our approach to public key distribution is to __introduce an independent, authoritative third-party authority__. Suppose there is now an authoritative certification authority for digital certificates, which will create a digital certificate for Bob, including some information about Bob and Bob's public key. So, at this point, the person who communicate with Bob, can check Bob's digital certificate, and use CA's public key to decrypt it. If so, Bob's public key __can be obtained from the digital certificate__, then it can prove whether the digital signature was actually signed by Bob. And then the secured communication can be conducted. Similarly, if one's information is not found in the certificate authority of the digital certificate, then the communication may not secure.
 ___
 */
/*:
 ___
 Getting a hand of it already? __Let's practise it!__
 ___
 */
import Cocoa
import PlaygroundSupport

let currentViewController = MainViewController.init()
PlaygroundPage.current.liveView = currentViewController.view
/*:
 ___
### NEXT PAGE:
[Next](@next)
 ___
 */
