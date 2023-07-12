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

{ #category : #dispatched }
WolframHandleHolder >> pushOnLua: L liblua: liblua [

	^ self handler pushOnLua: L liblua: liblua
]

{ #category : #'as yet unclassified' }
WolframHandleHolder >> releaseHandler [

	handler := nil
]
