Class {
	#name : #WolframLink,
	#superclass : #WolframHandleHolder,
	#category : #Wolfram
}

{ #category : #expressions }
WolframLink >> ! anObject [

	^ self head: 'ToExpression' arguments: { anObject  }
]

{ #category : #expressions }
WolframLink >> % anObject [

	^ self head: 'Out' arguments: { anObject }
]

{ #category : #expressions }
WolframLink >> << anObject [

	^ self head: 'Identity' arguments: { anObject }
]

{ #category : #operations }
WolframLink >> @ i [

	^ self head: 'Slot' arguments: { i }
]

{ #category : #expressions }
WolframLink >> _ [

	^ self head: 'Blank' arguments: {  }
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

{ #category : #'as yet unclassified' }
WolframLink >> arbitraryPrecisionNumber: numberAsString headIsInteger: bool [

	| expr |
	expr := bool
		        ifTrue: [
			        WolframArbitraryPrecisionInteger new
				        head: 'Integer';
				        yourself ]
		        ifFalse: [
			        WolframArbitraryPrecisionReal new
				        head: 'Real';
				        yourself ].

	^ expr
		  arguments: { numberAsString };
		  link: self;
		  yourself
]

{ #category : #'reflective operations' }
WolframLink >> doesNotUnderstand: message [

	| selector |
	selector := message selector.

	^ (selector beginsWith: '_')
		  ifTrue: [ self symbol: selector allButFirst asSymbol ]
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

	head isSymbol ifTrue: [ Error signal: 'A String object is required.' ].

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
WolframLink >> putArbitraryPrecisionNumber: s [

	^ self
		  ffiCall:
		  #( int WSPutRealNumberAsString #( void #* handler #, const char
		        #* s ) )
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
WolframLink >> putUTF8String: s len: l [

	^ self
		  ffiCall:
			  #( int WSPutUTF8String #( void #* handler #, const char #* s #,
			        int l ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> putUTF8Symbol: s len: l [

	^ self
		  ffiCall:
			  #( int WSPutUTF8Symbol #( void #* handler #, const char #* s #,
			        int l ) )
		  module: WolframLibrary
]

{ #category : #'as yet unclassified' }
WolframLink >> releaseHandler [

	^ self
		  ffiCall: #( void WSClose #( void #* handler ) )
		  module: WolframLibrary
]

{ #category : #accessing }
WolframLink >> symbol: sym [

	^ WolframSymbolExpression new
		  link: self;
		  head: 'Symbol';
		  arguments: { sym };
		  yourself
]
