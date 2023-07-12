Class {
	#name : #WolframEngine,
	#superclass : #Object,
	#category : #Wolfram
}

{ #category : #'as yet unclassified' }
WolframEngine class >> newEnvironment [

	^ WolframEnvironment basicNew
		  handler: self wsenv;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframEngine class >> wsenv [

	^ self
		  ffiCall: #( void #* WSInitialize #( NULL ) )
		  module: WolframLibrary
]
