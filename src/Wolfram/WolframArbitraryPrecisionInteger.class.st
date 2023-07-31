Class {
	#name : #WolframArbitraryPrecisionInteger,
	#superclass : #WolframArbitraryPrecisionNumber,
	#category : #Wolfram
}

{ #category : #evaluating }
WolframArbitraryPrecisionInteger >> putOnLink: alink [

	(alink head: 'FromDigits' arguments: self arguments) putOnLink: alink
]
