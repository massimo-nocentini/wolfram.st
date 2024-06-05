Class {
	#name : 'WolframEngine',
	#superclass : 'Object',
	#classVars : [
		'Env',
		'Link'
	],
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'accessing' }
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

{ #category : 'primitives' }
WolframEngine class >> wsenv [

	<primitive: 'primitive_WSInitialize' module: 'WolframPlugin'>
	self primitiveFailed
]
