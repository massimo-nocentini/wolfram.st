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
