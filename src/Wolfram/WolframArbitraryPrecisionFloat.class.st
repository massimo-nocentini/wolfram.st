Class {
	#name : #WolframArbitraryPrecisionFloat,
	#superclass : #WolframExpression,
	#category : #Wolfram
}

{ #category : #evaluating }
WolframArbitraryPrecisionFloat >> putOnLink: alink [

	(alink head: 'ToExpression' arguments: self arguments) putOnLink:
		alink
]
