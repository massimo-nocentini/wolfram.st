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
WolframEnvironment >> envHandle: envHandle commandLineString: str [

	<primitive: 'primitive_WSOpenString' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'instance creation' }
WolframEnvironment >> newLinkOpenString [

	^ self newLinkOpenString:
		  'pharo -linkmode launch -linkname "wolfram -wstp -noprompt -noicon"'
]

{ #category : 'instance creation' }
WolframEnvironment >> newLinkOpenString: str [

	^ WolframLink basicNew
		  handler: (self wsOpenString: str);
		  initialize;
		  yourself
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> releaseHandler [

	^ self deinitializeHandle: self handler
]

{ #category : 'as yet unclassified' }
WolframEnvironment >> wsOpenString: str [

	^ self envHandle: self handler commandLineString: str
]
