"
For the client:
`pharo -wstp -LinkMode Connect -LinkProtocol TCPIP -LinkName 8081@127.0.0.1`

For the server: 
`WolframKernel -noprompt -wstp -LinkMode Listen -LinkProtocol TCPIP -LinkName 8000@127.0.0.1`
"
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

			  Link := Env openLink ]
		  ifFalse: [
			  Link handler isNull ifFalse: [ Link releaseHandler ].
			  Env handler isNull ifFalse: [ Env releaseHandler ].

			  Link := Env := nil.

			  self link ]
]

{ #category : 'accessing' }
WolframEngine class >> newLink [

	^ WolframEnvironment new openLink
]

{ #category : 'see class side' }
WolframEngine >> seeClassSide [

	
]
