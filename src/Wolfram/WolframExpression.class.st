Class {
	#name : #WolframExpression,
	#superclass : #Object,
	#instVars : [
		'head',
		'arguments',
		'link',
		'showPdfInsteadOfTeX'
	],
	#category : #Wolfram
}

{ #category : #visiting }
WolframExpression >> && exp [

	^ link head: 'And' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> * exp [

	^ link head: 'Times' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> ** exp [

	^ link head: 'Power' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> + exp [

	^ link head: 'Plus' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> - exp [

	^ link head: 'Subtract' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> / exp [

	^ link head: 'Divide' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> /, exp [

	^ link head: 'ReplaceAll' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> <- exp [

	^ link head: 'Set' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> === exp [

	^ link head: 'Equal' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> @ exp [

	^ link head: 'Indexed' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> @! exp [

	^ link head: 'Part' arguments: {
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
WolframExpression >> asDefaultShapeForWalker: walker [

	^ showPdfInsteadOfTeX
		  ifTrue: [ self asExportedPdfShape ]
		  ifFalse: [ self asTeXifiedShape ]
]

{ #category : #evaluating }
WolframExpression >> asExportedPdfShape [

	| fileReference fullName |
	fileReference := FileReference
		                 newTempFilePrefix: 'wolfram-'
		                 suffix: ''.

	fullName := fileReference fullName , '.pdf'.

	(link head: 'Export' arguments: {
			 fullName.
			 self }) value.

	^ RSPdf new
		  model: self;
		  fileReference: fullName asFileReference;
		  yourself
]

{ #category : #evaluating }
WolframExpression >> asMathematicaPrintString [

	| liblua |
	link
		putFunction: 'TextString' arity: 1;
		putFunction: 'HoldForm' arity: 1;
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

{ #category : #evaluating }
WolframExpression >> asTeXifiedShape [

	| tmpFileName fileReference retcode last fullName liblua ret template cmd |
	fileReference := FileReference
		                 newTempFilePrefix: 'wolfram-'
		                 suffix: ''.

	fullName := fileReference fullName.

	last := fullName lastIndexOf: $/.

	tmpFileName := fullName copyFrom: last + 1 to: fullName size.

	retcode := link
		           putFunction: 'ToString' arity: 1;
		           putFunction: 'TeXForm' arity: 1;
		           putFunction: 'HoldForm' arity: 1;
		           putExpression: self;
		           endPacket;
		           flush.

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

	template := String streamContents: [ :aStream |
		            aStream
			            << self standaloneLatexPreamble;
			            << ret;
			            << self standaloneLatexFooter ].

	fileReference writeStreamDo: [ :aStream |
		aStream << template withUnixLineEndings ].

	cmd := 'pdflatex -output-directory=' , fileReference parent fullName
	       , ' ' , fullName.

	LibC runCommand: cmd. ";
		runCommand: cmd"

	^ RSPdf new
		  model: self;
		  fileReference: (fileReference fullName , '.pdf') asFileReference;
		  yourself
]

{ #category : #'reflective operations' }
WolframExpression >> doesNotUnderstand: message [

	^ link
		  head: (message selector copyReplaceAll: ':' with: String empty)
		  arguments: (OrderedCollection new
				   add: self;
				   addAll: (message arguments
						    ifEmpty: [ Array empty ]
						    ifNotEmpty: [ :args | args first ]);
				   yourself)
]

{ #category : #evaluating }
WolframExpression >> evaluate [

	^ self -> self value
]

{ #category : #accessing }
WolframExpression >> head [

	^ head
]

{ #category : #accessing }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : #initialization }
WolframExpression >> initialize [

	super initialize.

	showPdfInsteadOfTeX := false
]

{ #category : #testing }
WolframExpression >> isWolframExpression [

	^ true
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

{ #category : #accessing }
WolframExpression >> showPdfInsteadOfTeX [

	showPdfInsteadOfTeX := true
]

{ #category : #evaluating }
WolframExpression >> standaloneLatexFooter [

	^ ' \)
\end{document}'
]

{ #category : #evaluating }
WolframExpression >> standaloneLatexPreamble [

	^ '\documentclass[12pt]{standalone}
\usepackage{mathtools}
\usepackage{concrete}
\usepackage{euler}
\usepackage{amssymb}
\begin{document}
\(\displaystyle '
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
