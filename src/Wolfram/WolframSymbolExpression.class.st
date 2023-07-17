Class {
	#name : #WolframSymbolExpression,
	#superclass : #WolframExpression,
	#instVars : [
		'symbol'
	],
	#category : #Wolfram
}

{ #category : #evaluating }
WolframSymbolExpression >> putOnLink: aLink [

	symbol putOnLink: aLink
]

{ #category : #accessing }
WolframSymbolExpression >> symbol: anObject [

	symbol := anObject
]
