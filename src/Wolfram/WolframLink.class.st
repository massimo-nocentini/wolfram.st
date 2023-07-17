Class {
	#name : #WolframLink,
	#superclass : #WolframHandleHolder,
	#category : #Wolfram
}

{ #category : #expressions }
WolframLink >> ! anObject [

	^ self head: 'ToExpression' arguments: { anObject  }
]

{ #category : #'as yet unclassified' }
WolframLink >> acceptSlotDescriptorsVisitor: visitor [

	^ visitor visitWolframLink: self
]

{ #category : #'as yet unclassified' }
WolframLink >> activate [

	^ self
		  ffiCall: #( int WSActivate #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'reflective operations' }
WolframLink >> doesNotUnderstand: message [

	| selector |
	selector := message selector.

	^ (selector beginsWith: '_')
		  ifTrue: [
			  WolframSymbolExpression new
				  link: self;
				  head: 'Symbol';
				  arguments: { selector allButFirst asSymbol };
				  yourself ]
		  ifFalse: [
			  (message numArgs = 1 and: [ message argument isCollection ])
				  ifTrue: [
				  self head: selector allButLast arguments: message argument ]
				  ifFalse: [ super doesNotUnderstand: message ] ]
]

{ #category : #'as yet unclassified' }
WolframLink >> endPacket [

	^ self
		  ffiCall: #( int WSEndPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> flush [

	^ self
		  ffiCall: #( int WSFlush #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #expressions }
WolframLink >> head: head arguments: args [

	^ WolframExpression basicNew
		  link: self;
		  head: head;
		  arguments: args;
		  initialize;
		  yourself
]

{ #category : #'as yet unclassified' }
WolframLink >> name [

	^ self
		  ffiCall: #( const char #* WSLinkName #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> newPacket [

	^ self
		  ffiCall: #( int WSNewPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> nextPacket [

	^ self
		  ffiCall: #( int WSNextPacket #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putExpression: exp [

	^ exp putOnLink: self
]

{ #category : #'as yet unclassified' }
WolframLink >> putFloat: i [

	^ self
		  ffiCall: #( int WSPutReal #( void #* handler #, double i ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putFloatAsString: s [

	^ self
		  ffiCall:
		  #( int WSPutRealNumberAsString #( void #* handler #, const char
		        #* s ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putFunction: f arity: argc [

	^ self
		  ffiCall:
		  #( int WSPutFunction #( void #* handler #, const char #* f #, int
		        argc ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putInteger: i [

	^ self
		  ffiCall: #( int WSPutInteger64 #( void #* handler #, long i ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putString: s [

	^ self
		  ffiCall:
		  #( int WSPutString #( void #* handler #, const char #* s ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putSymbol: s [

	^ self
		  ffiCall:
		  #( int WSPutSymbol #( void #* handler #, const char #* s ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> releaseHandler [

	^ self
		  ffiCall: #( void WSClose #( void #* handler ) )
		  module: WolframLibrary
]
