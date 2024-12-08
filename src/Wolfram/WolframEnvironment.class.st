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
WolframEnvironment >> openLink [

	| handle |
	handle := self
		          wsOpenString: self wolframOpenString
		          environmentHandle: self handler.

	^ WolframLink new
		  handler: handle;
		  activate;
		  yourself
]

{ #category : 'resources' }
WolframEnvironment >> releaseHandler [

	^ self deinitializeHandle: self handler
]

{ #category : 'instance creation' }
WolframEnvironment >> wolframOpenString [
	"See also the [official doc page](https://reference.wolfram.com/language/tutorial/WSTPDeveloperGuide-Macintosh.html#594), where the program is invoked as: 
	
	`factor -linkmode launch -linkname '""/Applications/Mathematica.app/Contents/MacOS/WolframKernel"" -wstp'`
	"

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
