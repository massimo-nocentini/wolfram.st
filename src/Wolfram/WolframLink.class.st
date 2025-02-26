Class {
	#name : 'WolframLink',
	#superclass : 'WolframHandleHolder',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'expressions' }
WolframLink >> ! anObject [
	"https://reference.wolfram.com/language/ref/ToExpression.html"

	^ (self head: 'ToExpression' arguments: { anObject }) value
]

{ #category : 'expressions' }
WolframLink >> % anObject [

	^ self head: 'Out' arguments: { anObject }
]

{ #category : 'expressions' }
WolframLink >> << anObject [

	^ self head: 'Identity' arguments: { anObject }
]

{ #category : 'expressions' }
WolframLink >> @ i [
	"From the [official documentation](https://reference.wolfram.com/language/ref/Slot.html)"

	^ self head: 'Slot' arguments: { i }
]

{ #category : 'expressions' }
WolframLink >> _ [

	^ self head: 'Blank' arguments: {  }
]

{ #category : 'visiting' }
WolframLink >> acceptSlotDescriptorsVisitor: visitor [

	^ visitor visitWolframLink: self
]

{ #category : 'API' }
WolframLink >> activate [

	^ self activateLinkHandle: self handler
]

{ #category : 'primitives' }
WolframLink >> activateLinkHandle: handle [

	<primitive: 'primitive_WSActivate' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'resources' }
WolframLink >> close [

	<primitive: 'primitive_WSClose' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'API' }
WolframLink >> endPacket [

	^ self endPacketLinkHandle: self handler
]

{ #category : 'primitives' }
WolframLink >> endPacketLinkHandle: handle [

	<primitive: 'primitive_WSEndPacket' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'API' }
WolframLink >> evaluate [

	^ self
		  evaluateExpressionClass: WolframExpression
		  expressionSymbolClass: WolframSymbolExpression
		  expressionIntegerClass: WolframArbitraryPrecisionInteger
		  expressionRealClass: WolframArbitraryPrecisionReal
]

{ #category : 'primitives' }
WolframLink >> evaluateExpressionClass: eClass expressionSymbolClass: sClass expressionIntegerClass: iClass expressionRealClass: rClass [

	<primitive: 'primitive_read_from_link' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'API' }
WolframLink >> flush [

	^ self flushLinkHandle: self handler
]

{ #category : 'primitives' }
WolframLink >> flushLinkHandle: handle [

	<primitive: 'primitive_WSFlush' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'expressions' }
WolframLink >> head: head arguments: args [

	head isSymbol ifTrue: [ Error signal: 'A String object is required.' ].

	^ WolframExpression basicNew
		  link: self;
		  head: head;
		  arguments: args;
		  initialize;
		  yourself
]

{ #category : 'API' }
WolframLink >> name [

	^ self nameLinkHandle: self handler
]

{ #category : 'primitives' }
WolframLink >> nameLinkHandle: handle [

	<primitive: 'primitive_WSLinkName' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'API' }
WolframLink >> newPacket [

	<primitive: 'primitive_WSNewPacket' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'API' }
WolframLink >> nextPacket [

	<primitive: 'primitive_WSNextPacket' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'expressions' }
WolframLink >> number: anObject [

	^ WolframArbitraryPrecisionNumber new
		  link: self;
		  head: 'Number';
		  arguments: { anObject };
		  yourself
]

{ #category : 'API' }
WolframLink >> putArbitraryPrecisionNumber: s [

	<primitive: 'primitive_WSPutRealNumberAsUTF8String' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'dispatched' }
WolframLink >> putExpression: exp [

	^ exp putOnLink: self
]

{ #category : 'dispatched' }
WolframLink >> putFloat: i [

	<primitive: 'primitive_WSPutReal' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'dispatched' }
WolframLink >> putFunction: f arity: argc [

	<primitive: 'primitive_WSPutUTF8Function' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'dispatched' }
WolframLink >> putInteger: i [

	<primitive: 'primitive_WSPutInteger32' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'dispatched' }
WolframLink >> putString: s [

	<primitive: 'primitive_WSPutByteString' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'dispatched' }
WolframLink >> putSymbol: s [

	<primitive: 'primitive_WSPutByteSymbol' module: 'WolframPlugin'>
	self primitiveFailed
]

{ #category : 'resources' }
WolframLink >> releaseHandler [

	self close.

	super releaseHandler
]

{ #category : 'expressions' }
WolframLink >> symbol: sym [

	^ WolframSymbolExpression new
		  link: self;
		  head: 'Symbol';
		  arguments: { sym asString };
		  yourself
]
