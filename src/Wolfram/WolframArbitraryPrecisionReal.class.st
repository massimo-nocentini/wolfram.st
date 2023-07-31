Class {
	#name : #WolframArbitraryPrecisionReal,
	#superclass : #WolframArbitraryPrecisionNumber,
	#category : #Wolfram
}

{ #category : #evaluating }
WolframArbitraryPrecisionReal >> putOnLink: alink [

	alink putArbitraryPrecisionNumber: self arguments first
]
