Class {
	#name : #WolframExpression,
	#superclass : #WolframHandleHolder,
	#instVars : [
		'head',
		'arguments'
	],
	#category : #Wolfram
}

{ #category : #'as yet unclassified' }
WolframExpression class >> wsEndPacket: handler [

	^ self
		  ffiCall: #( int WSEndPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframExpression class >> wsPutFunction: handler name: f arity: argc [

	^ self
		  ffiCall:
		  #( int WSPutFunction #( void #* handler #, const char #* f #, int
		        argc ) )
		  module: WolframLibrary
]

{ #category : #accessing }
WolframExpression >> arguments [

	^ arguments
]

{ #category : #accessing }
WolframExpression >> arguments: anObject [

	arguments := anObject
]

{ #category : #converting }
WolframExpression >> asWolframExpressionInLink: link [

	^ self
]

{ #category : #accessing }
WolframExpression >> head [

	^ head
]

{ #category : #accessing }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : #evaluating }
WolframExpression >> value [

	self class wsPutFunction: self handler name: 'FullForm' arity: 1.

	self class
		wsPutFunction: self handler
		name: self head
		arity: self arguments size.

	self arguments do: #value.

	self class wsEndPacket: self handler
]
