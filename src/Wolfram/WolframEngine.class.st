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
			  Env := WolframEnvironment new.

			  Link := Env newLink
				          activate;
				          yourself ]
		  ifFalse: [
			  Link releaseHandler.
			  Env releaseHandler.

			  Link := Env := nil.

			  self link ]
]

{ #category : 'see class side' }
WolframEngine >> seeClassSide [

	
]
