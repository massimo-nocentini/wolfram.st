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

	| handle string |
	string := 'pharo -linkmode launch -linkname '
	          , self wolframCommandString.

	handle := self envHandle: self handler openString: string.

	^ WolframLink basicNew
		  handler: handle;
		  initialize;
		  yourself
]

{ #category : 'resources' }
WolframEnvironment >> releaseHandler [

	^ self deinitializeHandle: self handler
]

{ #category : 'instance creation' }
WolframEnvironment >> wolframCommandString [

	^ Smalltalk platform isMacOSX
		  ifTrue: [
			  '"/Applications/Wolfram\\ Engine.app/Contents/MacOS/WolframKernel  -wstp -noprompt -noicon"' ]
		  ifFalse: [ '"wolfram -wstp -noprompt -noicon"' ]
]
