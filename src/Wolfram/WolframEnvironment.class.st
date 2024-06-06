Class {
	#name : 'WolframEnvironment',
	#superclass : 'WolframHandleHolder',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'primitives' }
WolframEnvironment >> deinitializeHandle: handle [

	<primitive: 'primitive_WSDeinitialize' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'primitives' }
WolframEnvironment >> envHandle: envHandle openString: str [

	<primitive: 'primitive_WSOpenString' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'instance creation' }
WolframEnvironment >> newLinkOpenString [

	| handle |
	handle := self wsOpenString:
		          'pharo -linkmode launch -linkname '
		          , self wolframCommandString.

	^ WolframLink basicNew
		  handler: handle;
		  initialize;
		  yourself
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> releaseHandler [

	^ self deinitializeHandle: self handler
]

{ #category : 'instance creation' }
WolframEnvironment >> wolframCommandString [

	^ '"wolfram -wstp -noprompt -noicon"'
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> wsOpenString: str [

	^ self envHandle: self handler openString: str
]
