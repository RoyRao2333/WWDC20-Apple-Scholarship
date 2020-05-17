//: ## Let's Meet RSA!
/*:
 ___
 > In this page, you'll learn the basics about RSA algorithm and how it works.
 Good luck!
 ___
 We’ve got two encryption algorithm for common use in our daily life. They are __symmetric encryption algorithm__ and __asymmetric encryption algorithm__. This RSA we’re talking about belongs to __the latter one__.
 
 When we use RSA algorithm, we first generate a pair of keys, which we call __the public and private keys__. They’re in paris and they use each other to decrypt. You can save which one you like as the private key, and make another one as the public key. You don't just randomly generate them, you generate them based on some mathematical algorithm.
 
 Once we get both of the public and private keys, we can encrypt and send our message easily and safely!
 ___
 Seems easy, right? __Run the code and try it out yourself!__
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
