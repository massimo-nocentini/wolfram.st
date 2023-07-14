"
A WolframExpressionTest is a test class for testing the behavior of WolframExpression
"
Class {
	#name : #WolframExpressionTest,
	#superclass : #TestCase,
	#instVars : [
		'w'
	],
	#category : #'Wolfram-Tests'
}

{ #category : #'as yet unclassified' }
WolframExpressionTest >> executionOfSelector: selector [

	^ TestCaseExecution new
		  receiver: self;
		  compiledMethod: self class >> selector;
		  yourself
]

{ #category : #accessing }
WolframExpressionTest >> link: link [

	w := link
]

{ #category : #tests }
WolframExpressionTest >> testHeadSymbol [

	| sut |
	sut := w Head: { #x }.

	self assert: sut head equals: 'Head'.

	^ sut
]
