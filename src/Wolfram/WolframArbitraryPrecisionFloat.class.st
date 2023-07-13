Class {
	#name : #WolframArbitraryPrecisionFloat,
	#superclass : #Object,
	#instVars : [
		'definition'
	],
	#category : #Wolfram
}

{ #category : #accessing }
WolframArbitraryPrecisionFloat >> definition: anObject [

	definition := anObject
]

{ #category : #evaluating }
WolframArbitraryPrecisionFloat >> putOnLink: link [

	link putFloatAsString: definition
]
