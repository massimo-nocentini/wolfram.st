Class {
	#name : #WolframExpression,
	#superclass : #Object,
	#instVars : [
		'head',
		'arguments',
		'link'
	],
	#category : #Wolfram
}

{ #category : #visiting }
WolframExpression >> ** exp [

	^ link head: 'Power' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> - exp [

	^ link head: 'Minus' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitWolframExpression: self
]

{ #category : #accessing }
WolframExpression >> arguments [

	^ arguments
]

{ #category : #accessing }
WolframExpression >> arguments: anObject [

	arguments := anObject
]

{ #category : #evaluating }
WolframExpression >> asPdfShape [

	| tmpFileName fileReference retcode last fullName |
	fileReference := FileReference
		                 newTempFilePrefix: 'wolfram-'
		                 suffix: ''.

	fullName := fileReference fullName.

	last := fullName lastIndexOf: $/.

	tmpFileName := fullName copyFrom: last + 1 to: fullName size.

	retcode := link
		           putFunction: 'Export' arity: 2;
		           putString: fullName , '.tex';
		           putFunction: 'HoldForm' arity: 1;
		           putExpression: self;
		           endPacket;
		           flush;
		           nextPacket.

	"[ link nextPacket == 3 ] whileFalse: [ link newPacket ]."

	LibC runCommand:
		'pdflatex -output-directory=' , fileReference parent fullName , ' '
		, fullName , '.tex'.

	^ RSPdf new
		  fileReference: (fullName , '.pdf') asFileReference;
		  yourself
]

{ #category : #evaluating }
WolframExpression >> fullPangoPrintString [

	| liblua |
	link
		putFunction: 'TextString' arity: 1;
		"putFunction: 'TeXForm' arity: 1;"putFunction: 'HoldForm' arity: 1;
		putExpression: self;
		endPacket.

	liblua := LibLua uniqueInstance.

	^ liblua withOpenedLibsStateDo: [ :L |
		  liblua on: L assertLUAOK: [
			  liblua
				  luaL_requiref: L name: 'wolfram';
				  on: L push: #wolfram;
				  lua_getfield: L at: -1 name: 'evaluate';
				  on: L push: link;
				  lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		  liblua on: L at: -1 ]
]

{ #category : #accessing }
WolframExpression >> head [

	^ head
]

{ #category : #accessing }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : #accessing }
WolframExpression >> link: anObject [

	link := anObject
]

{ #category : #evaluating }
WolframExpression >> putOnLink: aLink [

	aLink putFunction: self head arity: self arguments size.

	self arguments do: [ :each | each putOnLink: aLink ]
]

{ #category : #evaluating }
WolframExpression >> value [

	| liblua ret |
	link
		putExpression: self;
		endPacket.

	liblua := LibLua uniqueInstance.

	ret := liblua withOpenedLibsStateDo: [ :L |
		       liblua on: L assertLUAOK: [
			       liblua
				       luaL_requiref: L name: 'wolfram';
				       on: L push: #wolfram;
				       lua_getfield: L at: -1 name: 'evaluate';
				       on: L push: link;
				       lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		       liblua on: L at: -1 ].

	^ ret reifyWolframExpressionOnLink: link
]
