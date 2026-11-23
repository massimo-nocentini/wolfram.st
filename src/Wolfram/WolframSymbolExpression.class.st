"
I am a symbol of the Wolfram Language, with its name as my only argument. I come from `symbol:` of a `WolframLink`, from `asWolframExpression:` of a Smalltalk `Symbol`, and from the answers of the kernel.
"
Class {
	#name : 'WolframSymbolExpression',
	#superclass : 'WolframExpression',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframSymbolExpression >> putOnLink: aLink [

	aLink putSymbol: self arguments first
]
