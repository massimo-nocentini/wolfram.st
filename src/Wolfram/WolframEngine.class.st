Class {
	#name : #WolframEngine,
	#superclass : #Object,
	#classVars : [
		'Env',
		'Link'
	],
	#category : #Wolfram
}

{ #category : #accessing }
WolframEngine class >> link [

	^ (Env isNil or: [ Link isNil ])
		  ifTrue: [
			  Env := WolframEnvironment basicNew
				         handler: self wsenv;
				         initialize;
				         yourself.

			  Link := Env newLinkOpenString
				          activate;
				          yourself ]
		  ifFalse: [
			  Link releaseHandler.
			  Env releaseHandler.

			  Link := Env := nil.

			  self link ]
]

{ #category : #'as yet unclassified' }
WolframEngine class >> wsenv [

	^ self
		  ffiCall: #( void #* WSInitialize #( NULL ) )
		  module: WolframLibrary
]
