Class {
	#name : 'WolframEnvironment',
	#superclass : 'WolframHandleHolder',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'primitives - WSTP' }
WolframEnvironment >> deinitializeHandle: handle [

	<primitive: 'primitive_WSDeinitialize' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'initialization' }
WolframEnvironment >> initialize [

	super initialize.

	self handler: self wsInitialize
]

{ #category : 'instance creation' }
WolframEnvironment >> newLink [

	| handle |
	handle := self
		          wsOpenString: self wolframOpenString
		          environmentHandle: self handler.

	^ WolframLink new
		  handler: handle;
		  yourself
]

{ #category : 'resources' }
WolframEnvironment >> releaseHandler [

	^ self deinitializeHandle: self handler
]

{ #category : 'instance creation' }
WolframEnvironment >> wolframOpenString [

	^ String streamContents: [ :aStream |
		  aStream
			  << 'pharo -linkmode launch -linkname "';
			  << Smalltalk platform wolframEngineExecutableFileName;
			  << ' -wstp -noprompt -noicon"' ]
]

{ #category : 'primitives - WSTP' }
WolframEnvironment >> wsInitialize [

	<primitive: 'primitive_WSInitialize' module: 'WolframPlugin'>
	^ ExternalAddress null
]

{ #category : 'primitives - WSTP' }
WolframEnvironment >> wsOpenString: str environmentHandle: envHandle [

	<primitive: 'primitive_WSOpenString' module: 'WolframPlugin'>
	self primitiveFailed
]
