Class {
	#name : #WolframSymbolExpression,
	#superclass : #WolframExpression,
	#category : #Wolfram
}

{ #category : #evaluating }
WolframSymbolExpression >> putOnLink: aLink [

	self arguments first putOnLink: aLink
]
