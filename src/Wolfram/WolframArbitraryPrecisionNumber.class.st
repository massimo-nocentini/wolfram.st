"
I am a Smalltalk number as a Wolfram expression: my only argument, which I put on the link as it is. I come from `number:` of a `WolframLink` and from `asWolframExpression:` of a `Number`. My subclasses are the numbers that `WolframLink` reads from the kernel.
"
Class {
	#name : 'WolframArbitraryPrecisionNumber',
	#superclass : 'WolframExpression',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframArbitraryPrecisionNumber >> putOnLink: alink [

	self arguments first putOnLink: alink
]
