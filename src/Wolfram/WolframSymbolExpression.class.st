Class {
	#name : 'WolframSymbolExpression',
	#superclass : 'WolframExpression',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframSymbolExpression >> putOnLink: aLink [

	self arguments first putOnLink: aLink
]
