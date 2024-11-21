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
