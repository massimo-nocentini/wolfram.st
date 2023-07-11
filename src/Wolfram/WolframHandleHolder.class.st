Class {
	#name : #WolframHandleHolder,
	#superclass : #Object,
	#instVars : [
		'handler'
	],
	#category : #Wolfram
}

{ #category : #accessing }
WolframHandleHolder >> handler [

	^ handler
]

{ #category : #accessing }
WolframHandleHolder >> handler: anObject [

	handler := anObject
]

{ #category : #'as yet unclassified' }
WolframHandleHolder >> releaseHandler [

	self subclassResponsibility
]
