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
	
	```
	factor -linkmode launch -linkname '""/Applications/Mathematica.app/Contents/MacOS/WolframKernel"" -wstp'
	```
	"

	^ String streamContents: [ :aStream |
		  aStream
			  << 'pharo -linkmode launch -linkname "';
			  << Smalltalk platform wolframEngineExecutableFileName;
			  << ' -wstp -noprompt -noicon"' ]
]

{ #category : 'instance creation' }
WolframEnvironment >> wolframOpenStringLinkConnect [
	"See also the [official doc page](https://reference.wolfram.com/language/tutorial/RunningTheWolframSystemFromWithinAnExternalProgram.html) and in the [introduction to `WSTPServer`](https://reference.wolfram.com/language/tutorial/IntroductionToWSTPServer.html#1601480540), where the program is invoked as: 
	
	```
	-linkmode connect -linkname 31415 -linkprotocol TCPIP -linkoptions 4
	```
	
	This is more suitable when you want to connect to an already running server.
	"

	^ 'pharo -linkmode connect -linkname 8081 -linkprotocol TCPIP -linkoptions 4'
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
